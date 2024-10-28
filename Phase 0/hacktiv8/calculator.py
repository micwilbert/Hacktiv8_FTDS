#penjumlahan
def tambah(a,b):
    return a + b

#pengurangan
def kurang(a,b):
    return a - b

#perkalian
def kali(a,b):
    return a * b

#pembagian 
def bagi (a,b):
    return a / b

def app():
    print("==="*10)
    print('Kalkulator Sederhana')
    print("==="*10)
    print('''Silahkan Pilih operasi matematika yang anda inginkan \n
    1. tambah
    2. kurang
    3. kali
    4. bagi
    ''')
    opsi = input("Masukkan pilihan 1 - 4 :")

    if opsi =='1':
        angka1 = int(input('Masukkan angka:'))
        angka2 = int(input('Masukkan angka:'))
        result = tambah(angka1,angka2)
        print(f'Hasil penjumlahan {angka1}, {angka2} :{result}')
    else:
        print('Masih dalam pengembangan')


         
