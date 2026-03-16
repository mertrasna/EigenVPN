# connect/disconnet/status screen
import customtkinter as ctk


class DashboardScreen(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, fg_color="transparent")

        self.is_connected = False

        self._build_ui()

    def _build_ui(self):
        # --- App name at top ---
        self.title_label = ctk.CTkLabel(
            self,
            text="EigenVPN",
            font=ctk.CTkFont(size=28, weight="bold")
        )
        self.title_label.pack(pady=(48, 0))

        # --- Status indicator (dot + text) ---
        self.status_frame = ctk.CTkFrame(self, fg_color="transparent")
        self.status_frame.pack(pady=(12, 0))

        self.status_dot = ctk.CTkLabel(
            self.status_frame,
            text="●",
            font=ctk.CTkFont(size=14),
            text_color="#e05252"  # red = disconnected
        )
        self.status_dot.pack(side="left", padx=(0, 6))

        self.status_text = ctk.CTkLabel(
            self.status_frame,
            text="Disconnected",
            font=ctk.CTkFont(size=14)
        )
        self.status_text.pack(side="left")

        # --- Big round connect button ---
        self.connect_button = ctk.CTkButton(
            self,
            text="Connect",
            width=160,
            height=160,
            corner_radius=80,  # makes it a circle
            font=ctk.CTkFont(size=20, weight="bold"),
            command=self._toggle_connection
        )
        self.connect_button.pack(pady=60)

        # --- Server IP label (empty until connected) ---
        self.ip_label = ctk.CTkLabel(
            self,
            text="",
            font=ctk.CTkFont(size=13),
            text_color="gray"
        )
        self.ip_label.pack()

    def _toggle_connection(self):
        """Flip between connected and disconnected state."""
        self.is_connected = not self.is_connected

        if self.is_connected:
            self.connect_button.configure(text="Disconnect", fg_color="#e05252", hover_color="#c04040")
            self.status_dot.configure(text_color="#52e052")   # green
            self.status_text.configure(text="Connected")
            self.ip_label.configure(text="Server IP: 0.0.0.0")  # placeholder for now
        else:
            self.connect_button.configure(text="Connect", fg_color=("#3B8ED0", "#1F6AA5"), hover_color=("#36719F", "#144870"))
            self.status_dot.configure(text_color="#e05252")   # red
            self.status_text.configure(text="Disconnected")
            self.ip_label.configure(text="")