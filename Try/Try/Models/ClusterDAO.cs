using System;
using System.Collections;

namespace Try.Models
{
    public class ClusterDAO
    {
        ArrayList clusters = new ArrayList();

        public ClusterDAO()
        {
            initialiseCluster();
        }

        public ArrayList getClusters()
        {
            return clusters;
        }

        public Cluster trackPostal(int postal)
        {
            foreach (Cluster cluster in clusters)
            {
                if (cluster.containsPostal(postal))
                {
                    return cluster;
                }
            }
            return null;
        }

        public string getColor(int postal)
        {
            Cluster cluster = trackPostal(postal);
            if (cluster != null)
            {
                return cluster.color;
            }
            return "#000000";
        }

        public string changePostal(int postal, string zone)
        {
            Cluster cluster = trackPostal(postal);
            if (cluster != null)
            {
                cluster.removePostalCode(postal);
                ArrayList a = cluster.postals;
            }
            cluster = trackCluster(zone);
            if(cluster != null)
            {
                cluster.addPostalCode(postal);
                ArrayList b = cluster.postals;
                
                return cluster.color;
            }
            else
            {
                return "#000000";
            }
        }

        public Cluster trackCluster(string zoneid)
        {
            foreach (Cluster cluster in clusters)
            {
                if (cluster.id == zoneid)
                {
                    return cluster;
                }
            }
            return null;
        }

        public string getClusterId(int postal)
        {
            return trackPostal(postal).id;
        }

        public void changeCluster(string id)
        {
            ArrayList postalcodes = new ArrayList();
            Cluster oldCluster = trackCluster("WHITE");
            Cluster newCluster = trackCluster(id);
            postalcodes = oldCluster.postals;

            while (postalcodes.Count>0)
            {
                int postal = (int)postalcodes[0];
                oldCluster.removePostalCode(postal);
                newCluster.addPostalCode(postal);
            }
        }

        public bool clusterExist(string clusterId)
        {
            foreach (Cluster cluster in clusters)
            {
                if (cluster.id == clusterId)
                {
                    return true;
                }
            }
            return false;
        }
        
        public void initialiseCluster()
        {
            clusters.Add(new Cluster("C1", "Central 1", new ArrayList { 5, 6, 7, 8 }, "#34D2DB"));
            clusters.Add(new Cluster("C2", "Central 2", new ArrayList { 1, 2, 4 }, "#DB8F34"));
            clusters.Add(new Cluster("C3", "Central 3", new ArrayList { 3, 17, 18, 19, 20, 21 }, "#D234DB"));
            clusters.Add(new Cluster("C4", "Central 4", new ArrayList { 22, 23, 24, 25, 30 }, "#60050C"));
            clusters.Add(new Cluster("C5", "Central 5", new ArrayList { }, "#9c993d"));
            clusters.Add(new Cluster("W1", "West 1", new ArrayList { 9, 10, 11, 13, 14, 15, 16 }, "#DBD234"));
            clusters.Add(new Cluster("W2", "West 2", new ArrayList { 12, 60 }, "#81DB34"));
            clusters.Add(new Cluster("W3", "West 3", new ArrayList { 61, 62, 63, 64 }, "#E55F5F"));
            clusters.Add(new Cluster("W4", "West 4", new ArrayList { }, "#055B60"));
            clusters.Add(new Cluster("NW1", "Northwest 1", new ArrayList { 26, 27, 28, 29 }, "#053460"));
            clusters.Add(new Cluster("NW2", "Northwest 2", new ArrayList { 58, 59, 65, 66, 67, 68, 69, 70, 71, 72 }, "#600556"));
            clusters.Add(new Cluster("NW3", "Northwest 3", new ArrayList { }, "#DB3439"));
            clusters.Add(new Cluster("N1", "North 1", new ArrayList { 31, 32, 56, 57 }, "#602C05"));
            clusters.Add(new Cluster("N2", "North 2", new ArrayList { 73, 74, 75, 76, 77, 78, 83 }, "#5C6005"));
            clusters.Add(new Cluster("N3", "North 3", new ArrayList { }, "#1D6005"));
            clusters.Add(new Cluster("NE1", "Northeast 1", new ArrayList { 33, 34, 35, 36, 37, 38, 39, 40, 41 }, "#05601B"));
            clusters.Add(new Cluster("NE2", "Northeast 2", new ArrayList { 53, 54, 55, 79, 80, 82 }, "#9c3d40"));
            clusters.Add(new Cluster("NE3", "Northeast 3", new ArrayList { }, "#7e3d9c"));
            clusters.Add(new Cluster("E1", "East 1", new ArrayList { 42, 43, 44, 45, 46, 47 }, "#3d5a9c"));
            clusters.Add(new Cluster("E2", "East 2", new ArrayList { 48, 49, 50, 51, 52, 81 }, "#3d9c6c"));
            clusters.Add(new Cluster("E3", "East 3", new ArrayList { }, "#6B34DB"));
            clusters.Add(new Cluster("WHITE", "White", new ArrayList { }, "#FFFFFF"));
        }

    }


}