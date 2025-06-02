<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Admin" %>
        <%@page import="com.example.ecom.model.Orderhist" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Customers List</title>
                    <link rel="stylesheet" href="/css/output.css" />
                </head>
                <% Admin admi=(Admin)session.getAttribute("admin"); %>

                    <body class="bg-gradient-to-b from-cyan-600 to-purple-950 min-h-screen text-white font-sans">
                        <!-- Navbar -->
                        <nav class="bg-gray-900 w-full text-gray-100 px-4 shadow-md">
                            <div class="flex flex-wrap justify-between items-center py-4">
                                <a href="adminhome.jsp" class="flex items-center space-x-3">
                                    <img src="/images/SwiftMart.png" class="h-14 rounded-2xl" alt="SwiftMart Logo" />
                                    <span class="text-2xl font-bold text-white">SwiftMart™</span>
                                </a>
                                <div class="flex flex-wrap justify-center gap-4 text-base font-medium mt-4 md:mt-0">
                                    <a href="adminhome" class="hover:text-cyan-500 transition">Active
                                        Sellers</a>
                                    <a href="passivesellers" class="hover:text-cyan-400 transition">Pending
                                        Sellers</a>
                                    <a href="customerlist" class="hover:text-cyan-400 transition">Customers</a>
                                    <a href="productlist" class="hover:text-cyan-400 transition">Products</a>
                                    <a href="orderslist" class="text-cyan-400 border-b-2">Orders</a>
                                </div>
                            </div>
                        </nav>

                        <div class="max-w-7xl mx-auto mt-8 px-4">
                            <h2 class="text-2xl font-semibold text-white mb-6">Welcome to SwiftMart, Admin
                                <%=admi.getUsername()%>
                            </h2>

                            <% List<Orderhist> op = (List<Orderhist>)request.getAttribute("allordhist");
                                    if(op.isEmpty()){ %>
                                    <div class="text-white text-lg">No orders present now.</div>
                                    <% } else { %>

                                        <!-- Orders Section -->
                                        <section class="grid lg:grid-cols-1 gap-6 p-6 md:grid-cols-2">
                                            <% for(Orderhist x: op) { int oid=x.getId(); String
                                                p_name=x.getProductname(); String p_pd=x.getProductdesc(); Double
                                                p_price=x.getProductprice(); int p_id=x.getProdid(); int
                                                bqty=x.getBqty(); int c_id=x.getCustid(); int s_id=x.getSelrid(); String
                                                c_name=x.getCustname(); String s_name=x.getSellername(); Double
                                                cost=p_price * bqty; String dt=x.getDatetime(); Double
                                                taken=x.getTaken(); Double ref=x.getRefunded(); String
                                                statusw=x.getOrderstatus(); String statusmessage="" ;
                                                if(statusw.equals("completed")){ statusmessage=ref> 0.0 ? "Refunded" :
                                                "Transaction done";
                                                } else if(statusw.equals("cancelled")){
                                                statusmessage = "Cancelled";
                                                } else if(statusw.equals("tfailed") && ref > 0){
                                                statusmessage = "Transaction failed";
                                                } else if(statusw.equals("ongoing")){
                                                statusmessage = "Ongoing";
                                                }
                                                %>

                                                <div
                                                    class="flex lg:h-[35vh] bg-gray-800/50 backdrop:blur-2xl border-b-4 border-gray-800 rounded-2xl shadow-xl overflow-hidden hover:shadow-2xl hover:-translate-y-1 transition-all duration-300">
                                                    <div class="w-1/3">
                                                        <img src="<%=x.getOimg()%>" alt="Product <%=oid%>"
                                                            class="object-cover h-auto lg:w-68 sm:w-full sm:h-68">
                                                    </div>

                                                    <div class="w-2/3 p-4 flex flex-col justify-between">
                                                        <div>
                                                            <h2 class="text-xl font-semibold text-white mb-1">
                                                                <%=p_name%>
                                                            </h2>
                                                            <p class="text-sm text-gray-300 mb-2">
                                                                <%=p_pd%>
                                                            </p>

                                                            <div class="text-sm text-gray-400 space-y-1 mb-2">
                                                                <p><span
                                                                        class="font-medium text-gray-200">Seller:</span>
                                                                    <%=s_name%> (ID: <%=s_id%>)
                                                                </p>
                                                                <p><span
                                                                        class="font-medium text-gray-200">Customer:</span>
                                                                    <%=c_name%> (ID: <%=c_id%>)
                                                                </p>
                                                                <p><span class="font-medium text-gray-200">Product
                                                                        ID:</span>
                                                                    <%=p_id%>
                                                                </p>
                                                                <p><span
                                                                        class="font-medium text-gray-200">Quantity:</span>
                                                                    <%=bqty%> |
                                                                        <span class="font-medium">Unit Price:</span> ₹
                                                                        <%=p_price%>
                                                                </p>
                                                                <p><span class="font-medium text-gray-200">Total
                                                                        Cost:</span> ₹<%=cost%>
                                                                </p>
                                                                <p><span class="font-medium text-gray-200">Date:</span>
                                                                    <%=dt%>
                                                                </p>
                                                            </div>
                                                        </div>

                                                        <div class="mt-2">
                                                            <% if(statusw.equals("appeal")) { %>
                                                                <div class="flex gap-2">
                                                                    <form action="acceptcancel" method="post">
                                                                        <input type="hidden" name="orderhist_id"
                                                                            value="<%=oid%>">
                                                                        <button type="submit"
                                                                            class="px-3 py-1 bg-green-600 hover:bg-green-700 text-white text-sm rounded-md transition">
                                                                            Accept
                                                                        </button>
                                                                    </form>
                                                                    <form action="rejectcancel" method="post">
                                                                        <input type="hidden" name="orderhist_id"
                                                                            value="<%=oid%>">
                                                                        <button type="submit"
                                                                            class="px-3 py-1 bg-red-600 hover:bg-red-700 text-white text-sm rounded-md transition">
                                                                            Reject
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                                <% } else if(statusw.equals("cnc")) { %>
                                                                    <p
                                                                        class="text-yellow-400 text-sm font-semibold mb-1">
                                                                        Can't be cancelled</p>
                                                                    <form action="rejectcancel" method="post">
                                                                        <input type="hidden" name="orderhist_id"
                                                                            value="<%=oid%>">
                                                                        <button type="submit"
                                                                            class="px-3 py-1 bg-red-600 hover:bg-red-700 text-white text-sm rounded-md transition">
                                                                            Reject
                                                                        </button>
                                                                    </form>
                                                                    <% } else { %>
                                                                        <p class="text-sm font-semibold text-cyan-400">
                                                                            <%=statusmessage%>
                                                                        </p>
                                                                        <% } %>
                                                        </div>
                                                    </div>
                                                </div>

                                                <% } %>
                                        </section>


                                        <% } %>
                        </div>

                        <!-- footer -->
                        <footer class="rounded-lg shadow-sm bg-gray-900 m-4">
                            <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                                <div class="sm:flex sm:items-center sm:justify-between">
                                    <a href="/sellerhome"
                                        class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
                                        <img src="images/SwiftMart.png" class="h-12 rounded-xl" alt="SwiftMart Logo" />
                                        <span
                                            class="self-center text-2xl font-semibold whitespace-nowrap text-white">SwiftMart™</span>
                                    </a>
                                    <ul
                                        class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
                                        <li>
                                            <a href="#" class="hover:underline me-4 md:me-6">About</a>
                                        </li>
                                        <li>
                                            <a href="#" class="hover:underline me-4 md:me-6">Privacy
                                                Policy</a>
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
                                <span class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">©
                                    2025
                                    <a href="https://flowbite.com/" class="hover:underline">SwiftMart™</a>. All
                                    Rights Reserved.</span>
                            </div>
                        </footer>
                        <script>
                            setInterval(function () {
                                location.reload();
                            }, 5000);
                        </script>
                    </body>

                </html>