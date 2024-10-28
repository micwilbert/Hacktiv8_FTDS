class CartItem:
    def __init__(self, name, price):
        self.name = name
        self.price = price

#Kelas untuk keranjang belanja
class ShoppingCart:
    def __init__(self):
        self.items = [] #List kosong untuk simpan barang 

    def add_item(self, name, price):
    #fungsi untuk menambah barang ke keranjang belanja
        item = CartItem(name, price)
        self.items.append(item)
        print(f"{name} berhasil ditambahkan ke keranjang belanja.")

    def remove_item(self, name):
    #fungsi untuk mengeluarkan barang dari keranjang belanja
        for item in self.items:
            if item.name == name:
                self.items.remove(item)
                print(f"{name} berhasil dikeluarkan dari keranjang belanja.")
                return
        else:
            print(f"{name} tidak ditemukan di keranjang belanja.")
    
    def show_items(self):
    #fungsi untuk menampilkan barang di keranjang belanja
        if not self.items:
            print("Keranjang belanja kosong.")
        else:
            print("Barang di keranjang belanja:")
            for i, item in enumerate(self.items, start=1):
                print(f"{i} | Nama Barang : {item.name} | Harga Barang : Rp {item.price}")

    def total_price(self):
    #fungsi untuk menampilkan total harga barang di keranjang belanja
        total = sum(item.price for item in self.items)
        return total

    def run(self):
    #fungsi untuk menjalankan aplikasi keranjang belanja
        while True:
            print("================================================")
            print("Selamat Datang di Keranjang Belanja Toko Makmur!")
            print("================================================")
            print("1. Menambah Barang")
            print("2. Hapus Barang")
            print("3. Tampilkan Barang di Keranjang")
            print("4. Lihat Total Belanja")
            print("5. Exit")
            choice = input ("Pilih menu (1-5): ")

            if choice == '1':
                try:
                    name = input("Masukkan nama barang: ")
                    price = float(input("Masukkan harga barang: "))
                    self.add_item(name,price)
                except ValueError:
                    print("Error: Masukkan harga yang valid.")
            
            elif choice == '2':
                name = input("Masukkan nama barang yang ingin dihapus: ")
                self.remove_item(name)
            
            elif choice == '3':
                self.show_items()
            
            elif choice == '4':
                total = self.total_price()
                print(f"Total harga belanja: Rp {total}")
            
            elif choice == '5':
                print("Terima kasih telah berbelanja di Toko Makmur!")
                break

            else:
                print("Error: Pilih antara 1-5.")

if __name__ == "__main__":
    #Menjalankan program
        cart = ShoppingCart()
        cart.run() 
    