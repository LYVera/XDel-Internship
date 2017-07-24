using System.Collections;

namespace Try.Models
{
    public class UserDAO
    {
        private ArrayList users = new ArrayList();

        public UserDAO()
        {

            users.Add(new User("admin", "123", "superadmin", new ArrayList { "C1", "C2", "C3", "C4", "C5", "E1", "E2", "E3", "N1", "N2", "N3", "NE1", "NE2", "NE3", "NW1", "NW2", "NW3", "W1", "W2", "W3", "W4"}));
            users.Add(new User("kaiyang", "qwe", "admin", new ArrayList { "C1", "C2", "C3", "C4", "C5", "E1", "E2", "E3", "N1", "N2", "N3", "NE1", "NE2", "NE3", }));
            users.Add(new User("vera", "asd", "admin", new ArrayList { "E1", "E2", "NE1", "NE2", "C1", "C2", "C3", "C4", "C5", "N1", "N2", "N3" }));
            users.Add(new User("weekiat", "zxc", "admin", new ArrayList { "NW1", "NW2", "W1", "W2", "W3", "NE1", "NE2", "NE3", "C1", "C2", "C3", "C4", "C5" }));
            users.Add(new User("kenny", "456", "manager", new ArrayList { "C1", "C2", "C3", "C4", "C5" }));
            users.Add(new User("john", "456", "manager", new ArrayList { "E1", "E2", "E3", }));
            users.Add(new User("lynn", "456", "manager", new ArrayList { "W1", "W2", "W3", "W4" }));
            users.Add(new User("kimberly", "456", "manager", new ArrayList { "N1", "N2" , "N3"}));
            users.Add(new User("janice", "456", "manager", new ArrayList { "NE1", "NE2", "NE3" }));
            users.Add(new User("benjamin", "456", "manager", new ArrayList { "NW1", "NW2", "NW3"}));
        }

        public User checkUser(string username, string password)
        {
            for(int i=0; i<users.Count; i++)
            {
                User user = (User)users[i];
                if (user.getUsername().Equals(username)) {
                    if (user.getPassword().Equals(password))
                    {
                        return user;
                    }
                }
            }
            return null;
        }

        public ArrayList retrieveUsers()
        {
            return users;
        }

        public void updateUser(string username, string role, ArrayList rights)
        {
            foreach(User user in users)
            {
                if(user.getUsername() == username)
                {
                    if(role != "--select--")
                    {
                        user.setRole(role);
                    }
                    user.setPostalcoderights(rights);
                }
            }
        }
    }


}