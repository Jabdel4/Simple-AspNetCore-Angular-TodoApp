using Microsoft.EntityFrameworkCore;
using TodoAppBackend.Models;

namespace TodoAppBackend.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<TodoItem> ToDoItems { get; set; }
    }
}
