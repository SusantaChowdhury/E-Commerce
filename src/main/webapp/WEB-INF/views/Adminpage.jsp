<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Admin Login</title>
        <link rel="stylesheet" href="/css/output.css">
    </head>

    <body class="bg-gray-900 min-h-screen flex items-center justify-center px-4">

        <div class="max-w-md bg-gray-200 rounded-xl shadow-xl p-6 space-y-6 w-full" style="width: 50vw;">

            <!-- Brand Header -->
            <div class="text-center">
                <img src="/images/SwiftMart.png" alt="SwiftMart Logo" class="h-20 mx-auto rounded-2xl shadow-xl" />
                <h1 class="text-3xl font-bold text-blue-700 mt-3">Admin's Login Page</h1>
                <p class="text-sm text-gray-500 mt-1">Only for the Admins</p>
                <a href="/" class="text-sm text-blue-600 hover:underline mt-2 inline-block">← Return to Home Page</a>
            </div>

            <!-- Customer Login Form -->
            <form action="LoginAdmin" method="post" class="space-y-5">
                <!-- Email Field -->
                <div>
                    <label for="cust_mail" class="block text-sm font-medium text-gray-700 mb-1">Admin Username</label>
                    <input type="text" id="admin_name" name="admin_name" placeholder="Enter your username" required
                        class="w-full px-4 py-2 bg-gray-100 shadow border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>

                <!-- Password Field -->
                <div>
                    <label for="cust_password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                    <input type="password" id="admin_password" name="admin_password" placeholder="•••••••••" required
                        class="w-full px-4 py-2 bg-gray-100 shadow border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>

                <!-- Error Message -->
                <% String getm=String.valueOf(request.getAttribute("msg")); if(getm!=null){ if(getm.equals("alfail")){
                    %>
                    <p class="text-center text-sm text-red-600 font-medium">
                        Wrong username or password
                    </p>
                    <% } } %>

                        <!-- Login Button -->
                        <div>
                            <button type="submit"
                                class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 rounded-lg transition duration-300">
                                Login
                            </button>
                        </div>
            </form>
        </div>
    </body>

    </html>