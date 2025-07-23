from config import email_conf
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

def send_booking_email(data):
    subject = "Paris Room booking Confirmation"
    sender = email_conf['sender_email']
    receiver = data['gmail_id']
    password = email_conf['password']

    body = f"""Dear {data['customer_name']}, ..."""  # (Use your textwrap formatted body here)

    message = MIMEMultipart()
    message["From"] = sender
    message["To"] = receiver
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    try:
        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(sender, password)
            server.sendmail(sender, receiver, message.as_string())
        print("Email sent.")
    except Exception as e:
        print(f"Error: {e}")
