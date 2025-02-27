import tkinter as tk


def centrar_ventana(ventana):

    ventana.update_idletasks()
    ancho_ventana = ventana.winfo_width()
    alto_ventana = ventana.winfo_height()

    ancho_pantalla = ventana.winfo_screenwidth()
    alto_pantalla = ventana.winfo_screenheight()
   
    x = (ancho_pantalla // 2) - (ancho_ventana // 2)
    y = (alto_pantalla // 2) - (alto_ventana // 2)

    ventana.geometry(f'{ancho_ventana}x{alto_ventana}+{x}+{y}')


ventana = tk.Tk()
ventana.title("MQ Distribuidora - Inicio")
ventana.geometry("400x300") 

centrar_ventana(ventana)

ventana.mainloop()