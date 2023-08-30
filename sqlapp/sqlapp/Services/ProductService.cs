using MySql.Data.MySqlClient;
using sqlapp.Models;


namespace sqlapp.Services
{

    // This service will interact with our Product data in the SQL database
    public class ProductService : IProductService
    {
        private readonly IConfiguration _configuration;
        public ProductService(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        private MySqlConnection GetConnection()
        {
            string connectionString = "Server=mysqlserver200030.mysql.database.azure.com; Port=3306; Database=appdb; Uid=sqladmin@mysqlserver200030; Pwd=Azure@123; SslMode=Preferred;";
            return new MySqlConnection(connectionString);
        }
        public List<Product> GetProducts()
        {
            List<Product> _product_lst = new List<Product>();
            string _statement = "SELECT ProductID,ProductName,Quantity from Products";
            MySqlConnection _connection = GetConnection();

            _connection.Open();

            MySqlCommand _sqlcommand = new MySqlCommand(_statement, _connection);

            using (MySqlDataReader _reader = _sqlcommand.ExecuteReader())
            {
                while (_reader.Read())
                {
                    Product _product = new Product()
                    {
                        ProductID = _reader.GetInt32(0),
                        ProductName = _reader.GetString(1),
                        Quantity = _reader.GetInt32(2)
                    };

                    _product_lst.Add(_product);
                }
            }
            _connection.Close();
            return _product_lst;
        }

    }
}

