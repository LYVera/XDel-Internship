namespace Try.Models
{
    public class ClusterDetails
    {
        public string id { get; set; }
        public double lat { get; set; }
        public double lng { get; set; }
        public int newJob { get; set; }
        public int delJob { get; set; }
        public int puJob { get; set; }

        public ClusterDetails(string i)
        {
            id = i;
            lat = 0;
            lng = 0;
            newJob = 0;
            delJob = 0;
            puJob = 0;
        }

        public void setLat(double l)
        {
            lat = l;
        }

        public void setLng(double l)
        {
            lng = l;
        }

        public void addNewJob(int nj)
        {
            newJob += nj;
        }

        public void addDelJob(int dj)
        {
            delJob += dj;
        }

        public void addPuJob(int pj)
        {
            puJob += pj;
        }

    }
}