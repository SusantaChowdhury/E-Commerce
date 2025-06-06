<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Contact Us</title>
        <link rel="icon" href="/images/SwiftMart.ico" type="image/x-icon" />
        <link rel="stylesheet" href="/css/output.css" />
    </head>

    <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen flex flex-col bg-cover items-center">
        <!-- navbar -->
        <nav class="bg-gray-900 w-full text-gray-100 px-4">

            <div class="flex flex-wrap justify-between items-center my-2">
                <a href="/" class="flex m-4 items-center space-x-3 rtl:space-x-reverse">
                    <img src="/images/SwiftMart.png" class="h-16 rounded-2xl" alt="SwiftMart Logo" />
                    <span
                        class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-3xl text-transparent font-sans font-semibold">SwiftMart™</span>
                </a>
                <div class="flex justify-center items-center text-lg font-medium gap-3">
                    <a href="/" class="px-1 hover:text-cyan-500 transition">Home</a>
                    <a href="aboutus" class="px-1 hover:text-cyan-500 transition">About</a>
                    <a href="contactus" class="px-1 border-b-2 text-cyan-500">Contact
                        Us</a>
                    <a href="Adminpage" class="px-1 hover:text-cyan-500 transition">Admin</a>
                </div>
            </div>
        </nav>

        <div class="flex flex-col items-center justify-center mt-8">
            <h1 class="text-4xl font-semibold text-white mb-4 font-mono">Welcome to <span
                    class="bg-gradient-to-r from-orange-600 via-yellow-400 to-red-600 bg-clip-text text-transparent font-sans font-bold">SwiftMart™</span>
            </h1>
            <p class="text-lg text-gray-200 mb-6">Your one-stop shop for everything you need!</p>

        </div>
        <!-- Contacts section -->
        <section
            class="m-6 flex flex-col justify-center items-center bg-[url(/images/shop.jpg)] bg-cover text-center rounded-lg">
            <div
                class="bg-gray-800/50 w-fit backdrop-blur-lg border text-white py-10 px-4 m-12 rounded-lg text-center shadow-2xl">
                <h2 class="text-3xl text-black font-semibold mb-6">Contact Us</h2>
                <p class="text-lg mb-6">We would love to hear from you! Whether you have questions, feedback, or just
                    want to say hello, feel free to reach out to us.</p>
                <p class="text-lg mb-6">You can contact us via phone or email:</p>
                <p class="text-lg mb-6">
                    Phone: <a href="tel:9062393675" class="text-amber-300 hover:underline">9062393675</a> | <a
                        href="tel:8697255425" class="text-amber-300 hover:underline">8697255425</a><br>
                    Email: <a href="mailto:gonrishabh@gmail.com"
                        class="text-amber-300 hover:underline">gonrishabh@gmail.com</a> | <a
                        href="mailto:sushantachowdhury24@gmail.com"
                        class="text-amber-300 hover:underline">sushantachowdhury24@gmail.com</a><br>
                </p>
                <p class="text-lg mb-6">We are here to assist you with any inquiries or concerns you may have.</p>
                <p class="text-lg mb-6">Thank you for choosing SwiftMart™!</p>
            </div>
        </section>

        <!-- footer -->
        <footer class="rounded-lg shadow-sm bg-gray-900 m-4" style="width: 96vw;">
            <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                <div class="sm:flex sm:items-center sm:justify-between">
                    <a href="/sellerhome" class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
                        <img src="images/SwiftMart.png" class="h-12 rounded-xl" alt="SwiftMart Logo" />
                        <span class="self-center text-2xl font-semibold whitespace-nowrap text-white">SwiftMart™</span>
                    </a>
                    <ul
                        class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
                        <li>
                            <a href="#" class="hover:underline me-4 md:me-6">About</a>
                        </li>
                        <li>
                            <a href="#" class="hover:underline me-4 md:me-6">Privacy Policy</a>
                        </li>
                        <li>
                            <a href="#" class="hover:underline me-4 md:me-6">Licensing</a>
                        </li>
                        <li>
                            <a href="#" class="hover:underline">Contact</a>
                        </li>
                    </ul>
                </div>
                <hr class="my-6 border-gray-200 sm:mx-auto dark:border-gray-700 lg:my-8" />
                <span class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2025
                    <a href="https://flowbite.com/" class="hover:underline">SwiftMart™</a>. All
                    Rights Reserved.</span>
            </div>
        </footer>

    </body>

    </html>