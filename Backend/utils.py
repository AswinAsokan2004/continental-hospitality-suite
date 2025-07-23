import random
import string

def generate_custom_id(prefix='gorm_', length=10):
    return prefix + ''.join(random.choices(string.ascii_lowercase + string.digits, k=length))
