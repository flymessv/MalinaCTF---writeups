import time
import random
import jwt
from flask import Flask, redirect, render_template, request, make_response, jsonify

app = Flask(__name__)

start_time = time.time()
random.seed(start_time)

def generate_secret():
    return f"secret_{random.randint(0, 1000000)}"

SECRET_KEY = generate_secret()
print(f"Server started at: {time.ctime(start_time)}")
print(f"Generated JWT secret: {SECRET_KEY}")

users = {
    "admin": {
        "password": "TS780<(:2mnj$Xwt9!LbeFU8=>5",  
        "role": "admin",
        "flag": "SSU{aL0_Jw7_dA_dA_R@nd0M}"
    }
}

@app.route('/')
def index():
    return redirect('/login')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        if not username or not password:
            return render_template('register.html', error="Username and password required")
        
        if username in users:
            return render_template('register.html', error="Username already exists")
        
        users[username] = {
            "password": password,
            "role": "user",
            "flag": "No flag for regular users"
        }
        
        payload = {'user': username, 'role': 'user'}
        token = jwt.encode(payload, SECRET_KEY, algorithm='HS256')
        
        response = make_response(redirect('/profile'))
        response.set_cookie('auth_token', token)
        return response
    
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        user = users.get(username)
        if user and user['password'] == password:
            payload = {'user': username, 'role': user['role']}
            token = jwt.encode(payload, SECRET_KEY, algorithm='HS256')
            
            response = make_response(redirect('/profile'))
            response.set_cookie('auth_token', token)
            return response
            
        return render_template('login.html', error="Invalid credentials")
    
    return render_template('login.html')

@app.route('/profile')
def profile():
    token = request.cookies.get('auth_token')
    if not token:
        return redirect('/login')
    
    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
        username = decoded.get('user')
        role = decoded.get('role')
        
        if username in users:
            user_data = users[username]
            return render_template(
                'profile.html',
                username=username,
                role=role,
                flag=user_data['flag'] if role == 'admin' else "No flag for regular users",
                registration_time=time.ctime()
            )
            
    except jwt.InvalidTokenError:
        pass
    
    return render_template('error.html', message="Invalid token"), 403

@app.route('/debug')
def uptime():
    return jsonify({
        "startup_time": time.ctime(start_time),
        "timestamp": start_time,
        "message": "Server startup time"
    })

@app.route('/logout')
def logout():
    response = make_response(redirect('/login'))
    response.delete_cookie('auth_token')
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
