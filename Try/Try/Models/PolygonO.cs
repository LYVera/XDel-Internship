namespace Try.Models
{
    public class PolygonO
    {
        public string Coordinates { get; set; }
        public string Color { get; set; }
        public int Id { get; set; }
        public string Cluster { get; set; }

        public PolygonO(string Coor, string C, int I, string Cl)
        {
            Coordinates = Coor;
            Color = C;
            Id = I;
            Cluster = Cl;
        }

        public string getCoordinates()
        {
            return Coordinates;
        }

        public void setColor(string c)
        {
            Color = c;
        }


    }
}