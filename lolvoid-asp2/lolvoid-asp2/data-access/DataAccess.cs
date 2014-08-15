using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using RiotSharp;

namespace lolvoid_asp2.data_access
{
    public class DataAccess
    {
        private RiotApi leagueApi;
        public DataAccess(string region)
        {
            leagueApi = RiotApi.GetInstance("3119d025-1e34-4216-9150-d3d86dca602e", false);
        }

        public Summoner getSummonerByName(string name, int region)
        {

            try
            {
                var summoner = leagueApi.GetSummoner((Region) region, name);
                return summoner;
            }
            catch (RiotSharpException ex)
            {

                throw ex;
                
            }
        }
    }
}