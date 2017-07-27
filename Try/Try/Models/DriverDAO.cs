using System;
using System.Collections;

namespace Try.Models
{
    public class DriverDAO
    {
        private ArrayList drivers;

        public DriverDAO()
        {
            drivers = new ArrayList();
            initialiseDrivers();
        }

        public void addDriver(string name, string coordinator)
        {
            drivers.Add(new Driver(name, coordinator));
        }

        public ArrayList getDrivers()
        {
            return drivers;
        }

        public bool editDriver(string name, string coordinator)
        {
            foreach (Driver driver in drivers)
            {
                if(driver.getName() == name)
                {
                    driver.setCoordinator(coordinator);
                    return true;
                }
            }
            return false;
        }

        public void initialiseDrivers()
        {
            LukeRefL2.DriverObject[] arrayOfDrivers = getDriverArray();
            ArrayList driverList = new ArrayList();
            ArrayList userList = PostalCodeInitializer.retrieveAllUsers();
            for (int i = 0; i < arrayOfDrivers.Length; i++)
            {
                User user = (User)userList[i % userList.Count];
                if(user.getUsername() == "admin")
                {
                    user = (User)userList[1];
                }
                drivers.Add(new Driver(arrayOfDrivers[i].Name, user.getUsername()));
            }
        }


        
        public static LukeRefL2.DriverObject[] getDriverArray()
        {
            LukeRefL2.L2 luke2Obj = new LukeRefL2.L2();

            LukeRefL2.DriverObject[] arrayOfDrivers = luke2Obj.GetL2Drivers("130FEE3E0ACA2B608929CE0DEA1C15812365AAE6");
            return arrayOfDrivers;

        }

        public string sortClusters(int number)
        {
            ArrayList clusters = PostalCodeInitializer.getClusters();
            Cluster cluster = (Cluster)clusters[number % 21];
            return cluster.id;
        }
    }
}