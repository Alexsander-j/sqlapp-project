using sqlapp.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace sqlapp.Services
{
    public interface IProductService
    {
        Task<List<Products>> GetProducts();
    }
}