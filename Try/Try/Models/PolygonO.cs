namespace Try.Models
{
    public class PolygonO
    {
        public string Coordinates { get; set; }
        public string Color { get; set; }
        public int Id { get; set; }

        public PolygonO(string Coor, string C, int I)
        {
            Coordinates = Coor;
            Color = C;
            Id = I;
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

