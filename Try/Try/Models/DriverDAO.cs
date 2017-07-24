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

        public void addDriver(string name, string cluster)
        {
            drivers.Add(new Driver(name, cluster));
        }

        public ArrayList getDrivers()
        {
            return drivers;
        }

        public bool editDriver(string name, string cluster)
        {
            foreach (Driver driver in drivers)
            {
                if(driver.getName() == name)
                {
                    driver.setCluster(cluster);
                    return true;
                }
            }
            return false;
        }

        public void initialiseDrivers()
        {
            LukeRefL2.DriverObject[] arrayOfDrivers = getDriverArray();
            ArrayList driverList = new ArrayList();
            for (int i = 0; i < arrayOfDrivers.Length; i++)
            {
                drivers.Add(new Driver(arrayOfDrivers[i].Name, sortClusters(i)));
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