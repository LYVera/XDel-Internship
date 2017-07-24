using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Try.Models
{
    public class GlobalVariable
    {
        public String apiKey { get; set; }

        public GlobalVariable()
        {
            apiKey = "130FEE3E0ACA2B608929CE0DEA1C15812365AAE6";
        }

        public String getKey()
        {
            return apiKey;
        }

    }

   
}