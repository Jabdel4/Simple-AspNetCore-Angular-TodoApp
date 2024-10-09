using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TodoAppBackend.Data;
using TodoAppBackend.Models;

namespace TodoAppBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ToDoItemsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ToDoItemsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/ToDoItems
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TodoItem>>> GetToDoItems()
        {
            return await _context.ToDoItems.ToListAsync();
        }

        // GET: api/ToDoItems/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TodoItem>> GetToDoItem(int id)
        {
            var TodoItem = await _context.ToDoItems.FindAsync(id);

            if (TodoItem == null)
            {
                return NotFound();
            }

            return TodoItem;
        }

        // POST: api/ToDoItems
        [HttpPost]
        public async Task<ActionResult<TodoItem>> PostToDoItem(TodoItem TodoItem)
        {
            _context.ToDoItems.Add(TodoItem);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetToDoItem), new { id = TodoItem.Id }, TodoItem);
        }

        // PUT: api/ToDoItems/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutToDoItem(int id, TodoItem TodoItem)
        {
            if (id != TodoItem.Id)
            {
                return BadRequest();
            }

            _context.Entry(TodoItem).State = EntityState.Modified;

            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/ToDoItems/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteToDoItem(int id)
        {
            var TodoItem = await _context.ToDoItems.FindAsync(id);
            if (TodoItem == null)
            {
                return NotFound();
            }

            _context.ToDoItems.Remove(TodoItem);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
