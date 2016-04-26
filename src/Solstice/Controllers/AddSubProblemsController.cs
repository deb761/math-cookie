using System.Linq;
using Microsoft.AspNet.Mvc;
using Microsoft.AspNet.Mvc.Rendering;
using Microsoft.Data.Entity;
using Solstice.Models;

namespace Solstice.Controllers
{
    public class AddSubProblemsController : Controller
    {
        private ApplicationDbContext _context;

        public AddSubProblemsController(ApplicationDbContext context)
        {
            _context = context;    
        }

        // GET: AddSubProblems
        public IActionResult Index()
        {
            return View(_context.AddSubProblem.ToList());
        }

        // GET: AddSubProblems/Details/5
        public IActionResult Details(int? id)
        {
            if (id == null)
            {
                return HttpNotFound();
            }

            AddSubProblem addSubProblem = _context.AddSubProblem.Single(m => m.AddSubProblemID == id);
            if (addSubProblem == null)
            {
                return HttpNotFound();
            }

            return View(addSubProblem);
        }

        // GET: AddSubProblems/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: AddSubProblems/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(AddSubProblem addSubProblem)
        {
            if (ModelState.IsValid)
            {
                _context.AddSubProblem.Add(addSubProblem);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(addSubProblem);
        }

        // GET: AddSubProblems/Edit/5
        public IActionResult Edit(int? id)
        {
            if (id == null)
            {
                return HttpNotFound();
            }

            AddSubProblem addSubProblem = _context.AddSubProblem.Single(m => m.AddSubProblemID == id);
            if (addSubProblem == null)
            {
                return HttpNotFound();
            }
            return View(addSubProblem);
        }

        // POST: AddSubProblems/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(AddSubProblem addSubProblem)
        {
            if (ModelState.IsValid)
            {
                _context.Update(addSubProblem);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(addSubProblem);
        }

        // GET: AddSubProblems/Delete/5
        [ActionName("Delete")]
        public IActionResult Delete(int? id)
        {
            if (id == null)
            {
                return HttpNotFound();
            }

            AddSubProblem addSubProblem = _context.AddSubProblem.Single(m => m.AddSubProblemID == id);
            if (addSubProblem == null)
            {
                return HttpNotFound();
            }

            return View(addSubProblem);
        }

        // POST: AddSubProblems/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            AddSubProblem addSubProblem = _context.AddSubProblem.Single(m => m.AddSubProblemID == id);
            _context.AddSubProblem.Remove(addSubProblem);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
