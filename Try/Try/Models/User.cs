﻿using System;
using System.Collections;

namespace Try.Models
{
    public class User
    {
        private string username { get; set; }
        private string password { get; set; }
        private string role { get; set; }
        private ArrayList postalcoderights { get; set; }
        private ArrayList subodinates { get; set; }

        public User(string u, string p, string r, ArrayList pcr, ArrayList s)
        {
            username = u;
            password = p;
            role = r;
            postalcoderights = pcr;
            subodinates = s;
        }

        public string getUsername()
        {
            return username;
        }

        public string getPassword()
        {
            return password;
        }

        public ArrayList getPostalCodeRights()
        {
            return postalcoderights;
        }

        public string getRole()
        {
            return role;
        }

        public ArrayList getSubodinates()
        {
            return subodinates;
        }

        public Boolean haveRights(string id)
        {
            foreach(String rights in postalcoderights)
            {
                if (rights == id)
                {
                    return true;
                }
            }
            return false;
        }

        public void setRole(string r)
        {
            role = r;
        }

        public void setPostalcoderights(ArrayList rights)
        {
            postalcoderights = rights;
        }
    }
}