import socket
import RPi.GPIO as GPIO

SERVO_PIN = 17
PORT = 65432


def setupGPIO():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(SERVO_PIN, GPIO.OUT)


def start(pwm):
    new_p = GPIO.PWM(SERVO_PIN, 50)
    new_p.start(pwm)
    return new_p


def update_dc(value):
    p.ChangeDutyCycle(value)


def handle_data():
    split_data = data.split(":")
    if split_data[0] == "start":
        return start(float(split_data[1]))
    elif split_data[0] == "stop":
        p.stop()
    elif split_data[0] == "dc":
        update_dc(float(split_data[1]))

    return p


print("Setting up GPIO")
setupGPIO()

print("Starting server on port", PORT)
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind(("", PORT))
    s.listen()

    while True:
        conn, addr = s.accept()
        with conn:
            p = None
            print("Connected by", addr)

            while True:
                data = conn.recv(1024)
                if data:
                    data = data.decode("utf-8")
                    p = handle_data()
                else:
                    break
        print("Lost connection")
