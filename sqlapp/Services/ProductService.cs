using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using sqlapp.Models;
using StackExchange.Redis;
using System.Data.SqlClient;

namespace sqlapp.Services
{

    // This service will interact with our Product data in the SQL database
    public class ProductService : IProductService
    {
        private readonly IConnectionMultiplexer _redis;
        public ProductService(IConnectionMultiplexer redis)
        {
            _redis = redis;
        }
        private SqlConnection GetConnection()
        {
            string connectionString = "Server=tcp:sqlserver486152684512385.database.windows.net,1433;Initial Catalog=sqldatabase175963;Persist Security Info=False;User ID=4dm1n157r470r;Password=sa!&+k4pstnR;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
            return new SqlConnection(connectionString);
        }
        public async Task<List<Products>> GetProducts()
        {
            List<Products> _product_lst = new List<Products>();
            IDatabase database = _redis.GetDatabase();
            string key = "productlist";

            if (await database.KeyExistsAsync(key))
            {
                long listLenght = database.ListLength(key);
                for (int i = 0; i < listLenght; i++)
                {
                    string value = database.ListGetByIndex(key, i);
                    Products product = JsonConvert.DeserializeObject<Products>(value);
                    _product_lst.Add(product);
                }
                return _product_lst;
            }
            else
            {
                string _statement = "SELECT ProductId,ProductName,Quantity from Products";
                SqlConnection _connection = GetConnection();

                _connection.Open();

                SqlCommand _sqlCommand = new SqlCommand(_statement, _connection);

                using (SqlDataReader _reader = _sqlCommand.ExecuteReader())
                {
                    while (_reader.Read())
                    {
                        Products _product = new Products()
                        {
                            ProductID = _reader.GetInt32(0),
                            ProductName = _reader.GetString(1),
                            Quantity = _reader.GetInt32(2)
                        };
                        database.ListRightPush(key, JsonConvert.SerializeObject(_product));
                        _product_lst.Add(_product);
                    }
                }
                _connection.Close();
                return _product_lst;
            }
        }
    }
};