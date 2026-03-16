# app entry point, window setup
import customtkinter as ctk
from dashboard import DashboardScreen

ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("blue")


class App(ctk.CTk):
    def __init__(self):
        super().__init__()

        self.title("EigenVPN")
        self.geometry("480x600")
        self.resizable(False, False)

        self.current_screen = DashboardScreen(self)  
        self.current_screen.pack(fill="both", expand=True)  


if __name__ == "__main__":
    app = App()
    app.mainloop()