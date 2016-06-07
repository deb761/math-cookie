using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using Solstice.Models;
using SolsticeAPI.Models;

namespace SolsticeAPI.Controllers
{
    public class AddSubProblemsController : ApiController
    {
        private SolsticeAPIContext db = new SolsticeAPIContext();

        // GET: api/AddSubProblems
        public IQueryable<AddSubProblem> GetAddSubProblems()
        {
            return db.AddSubProblems;
        }

        // GET: api/AddSubProblems/5
        [ResponseType(typeof(AddSubProblem))]
        public async Task<IHttpActionResult> GetAddSubProblem(int id)
        {
            AddSubProblem addSubProblem = await db.AddSubProblems.FindAsync(id);
            if (addSubProblem == null)
            {
                return NotFound();
            }

            return Ok(addSubProblem);
        }

        // PUT: api/AddSubProblems/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutAddSubProblem(int id, AddSubProblem addSubProblem)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != addSubProblem.AddSubProblemID)
            {
                return BadRequest();
            }

            db.Entry(addSubProblem).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AddSubProblemExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/AddSubProblems
        [ResponseType(typeof(AddSubProblem))]
        public async Task<IHttpActionResult> PostAddSubProblem(AddSubProblem addSubProblem)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.AddSubProblems.Add(addSubProblem);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = addSubProblem.AddSubProblemID }, addSubProblem);
        }

        // DELETE: api/AddSubProblems/5
        [ResponseType(typeof(AddSubProblem))]
        public async Task<IHttpActionResult> DeleteAddSubProblem(int id)
        {
            AddSubProblem addSubProblem = await db.AddSubProblems.FindAsync(id);
            if (addSubProblem == null)
            {
                return NotFound();
            }

            db.AddSubProblems.Remove(addSubProblem);
            await db.SaveChangesAsync();

            return Ok(addSubProblem);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AddSubProblemExists(int id)
        {
            return db.AddSubProblems.Count(e => e.AddSubProblemID == id) > 0;
        }
    }
}