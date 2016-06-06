using CryptSharp;
using System.Text;

namespace Solstice
{
    /// <summary>
    /// A class that provides functions for security
    /// </summary>
    public static class Security
    {
        /// <summary>
        /// Hash the password
        /// </summary>
        /// <param name="password"></param>
        /// <returns>password hash and salt</returns>
        public static string HashPassword(string password)
        {
            string salt = Crypter.Blowfish.GenerateSalt(6);
            string crypted = Crypter.Blowfish.Crypt(key: Encoding.ASCII.GetBytes(password),
                salt: salt);
            return crypted + salt;
        }

    }
}