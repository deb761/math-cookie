using System.Linq;
using Microsoft.AspNet.Mvc;
using Microsoft.AspNet.Mvc.Rendering;
using Microsoft.Data.Entity;
using Solstice.Models;

namespace Solstice.Controllers
{
    public class ResultsController : Controller
    {
        private ApplicationDbContext _context;

        public ResultsController(ApplicationDbContext context)
        {
            _context = context;    
        }

        // GET: Results
        public IActionResult Index()
        {
            return View(_context.Result.ToList());
        }

        // GET: Results/Details/5
        public IActionResult Details(int? id)
        {
            if (id == null)
            {
                return HttpNotFound();
            }

            Result result = _context.Result.Single(m => m.ResultID == id);
            if (result == null)
            {
                return HttpNotFound();
            }

            return View(result);
        }

        // GET: Results/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Results/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Result result)
        {
            if (ModelState.IsValid)
            {
                _context.Result.Add(result);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(result);
        }

        // GET: Results/Edit/5
        public IActionResult Edit(int? id)
        {
            if (id == null)
            {
                return HttpNotFound();
            }

            Result result = _context.Result.Single(m => m.ResultID == id);
            if (result == null)
            {
                return HttpNotFound();
            }
            return View(result);
        }

        // POST: Results/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(Result result)
        {
            if (ModelState.IsValid)
            {
                _context.Update(result);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(result);
        }

        // GET: Results/Delete/5
        [ActionName("Delete")]
        public IActionResult Delete(int? id)
        {
            if (id == null)
            {
                return HttpNotFound();
            }

            Result result = _context.Result.Single(m => m.ResultID == id);
            if (result == null)
            {
                return HttpNotFound();
            }

            return View(result);
        }

        // POST: Results/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            Result result = _context.Result.Single(m => m.ResultID == id);
            _context.Result.Remove(result);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
