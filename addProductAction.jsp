<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException"%>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        // Retrieve form data
        String name = request.getParameter("name");
        String brandId = request.getParameter("brand_id");
        String price = request.getParameter("price");
        String color = request.getParameter("color");
        String specification = request.getParameter("specification");
        String image = request.getParameter("image");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish the connection
            String url = "jdbc:mysql://localhost:3306/ultras"; // Adjust the URL, database name
            String userName = "root"; // Your MySQL user
            String password = ""; // Your MySQL password
            conn = DriverManager.getConnection(url, userName, password);

            // Prepare the SQL query
            String query = "INSERT INTO products (name, brand_id, price, color, specification, image) VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(query);

            // Set the parameters
            ps.setString(1, name);
            ps.setInt(2, Integer.parseInt(brandId));
            ps.setDouble(3, Double.parseDouble(price));
            ps.setString(4, color);
            ps.setString(5, specification);
            ps.setString(6, image);

            // Execute the query
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
%>
                <script>
                    alert('Product added successfully!');
                    window.location.href = 'viewproduct.jsp';
                </script>
<%
            } else {
                out.println("An error occurred while adding the product.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
