
# Importing the unittest module
import unittest

# Defining the functions to be tested
def calories_burned(duration, exercise):
    # Definisikan kalori terbakar per menit untuk setiap kegiatan
    calories_per_minute = {
        'berlari': 10,
        'bersepeda': 8,
        'berenang': 12
    }
    
    # Menghitung total kalori terbakar
    if exercise.lower() in calories_per_minute:
        total_calories = duration * calories_per_minute[exercise.lower()]
        return total_calories
    else:
        return "Jenis kegiatan tidak dikenali."

def total_session_burned_cal(*args, each_session_duration):
    total_calories = 0
    i = 0
    
    # Menggunakan while loop untuk iterasi melalui args
    while i < len(args):
        # Menggunakan fungsi calories_burned untuk menghitung kalori terbakar per sesi
        total_calories += calories_burned(each_session_duration, args[i])
        i += 1
    
    return total_calories

# Unit Testing Class
class TestCaloriesFunctions(unittest.TestCase):

    # Test for calories_burned function
    def test_calories_burned(self):
        self.assertEqual(calories_burned(60, 'berenang'), 720)
        self.assertEqual(calories_burned(15, 'berlari'), 150)
        self.assertEqual(calories_burned(20, 'bersepeda'), 160)
        self.assertEqual(calories_burned(30, 'lompat tali'), "Jenis kegiatan tidak dikenali.")

    # Test for total_session_burned_cal function
    def test_total_session_burned_cal(self):
        self.assertEqual(total_session_burned_cal('berenang', 'bersepeda', each_session_duration=10), 200)
        self.assertEqual(total_session_burned_cal('berenang', 'berlari', 'bersepeda', each_session_duration=5), 150)
        self.assertEqual(total_session_burned_cal('berlari', 'bersepeda', each_session_duration=20), 360)

# Running the tests
if __name__ == "__main__":
    unittest.main()
