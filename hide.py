import tkinter as tk
from tkinter import filedialog, messagebox
from PIL import Image
import numpy as np

def hide_text_in_image():
    img_path = filedialog.askopenfilename(title="Select Image", filetypes=[("PNG files", "*.png")])
    if not img_path:
        return

    text = text_entry.get()
    if not text:
        messagebox.showwarning("Input Error", "Please enter some text to hide.")
        return

    img = Image.open(img_path)
    img_data = np.array(img)

    # Convert text to binary
    binary_text = ''.join(format(ord(i), '08b') for i in text) + '11111111'  # Terminator
    data_index = 0

    for row in img_data:
        for pixel in row:
            for color in range(3):  # R, G, B
                if data_index < len(binary_text):
                    pixel[color] = (pixel[color] & ~1) | int(binary_text[data_index])
                    data_index += 1

    img.save("output_image.png")
    messagebox.showinfo("Success", "Text hidden in output_image.png")

def extract_text_from_image():
    img_path = filedialog.askopenfilename(title="Select Image with Hidden Text", filetypes=[("PNG files", "*.png")])
    if not img_path:
        return

    img = Image.open(img_path)
    img_data = np.array(img)
    binary_text = ""

    for row in img_data:
        for pixel in row:
            for color in range(3):
                binary_text += str(pixel[color] & 1)

    # Split binary text into characters
    decoded_text = ""
    for i in range(0, len(binary_text), 8):
        byte = binary_text[i:i+8]
        if byte == "11111111":  # Terminator
            break
        decoded_text += chr(int(byte, 2))

    messagebox.showinfo("Extracted Text", decoded_text if decoded_text else "No text found.")

app = tk.Tk()
app.title("Steganography Tool")

text_label = tk.Label(app, text="Enter text to hide:")
text_label.pack(pady=5)

text_entry = tk.Entry(app, width=50)
text_entry.pack(pady=5)

hide_button = tk.Button(app, text="Hide Text in Image", command=hide_text_in_image)
hide_button.pack(pady=5)

extract_button = tk.Button(app, text="Extract Text from Image", command=extract_text_from_image)
extract_button.pack(pady=5)

app.mainloop()
