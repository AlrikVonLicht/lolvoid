using lolvoid_asp2.data_access;
using RiotSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace lolvoid_asp2
{
    public partial class home : System.Web.UI.Page
    {
        DataAccess da = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            da = new DataAccess("NA");
        }
        protected void generateSummonerPage(Summoner sum, List<ChampionStats> champStats, List<League> leagueInfo)
        {
            SummonerNameLabel.Text = sum.Name;
            SummonerProfileIconIdLabel.Text = "<img class=\"img-responsive\" src=\"http://ddragon.leagueoflegends.com/cdn/4.11.3/img/profileicon/" + sum.ProfileIconId.ToString() + ".png\" />";
            int totalSessionsPlayed = 0;
            foreach(ChampionStats cs in champStats){
                if (cs.ChampionId != 0)
                {
                    TableRow tr = new TableRow();
                    TableCell champion = new TableCell();
                    champion.Text = "<img class=\"img-responsive\" src=img/champions/" + cs.ChampionId.ToString() + ".png />";
                    tr.Cells.Add(champion);

                    TableCell games = new TableCell();
                    games.Text = cs.Stats.TotalSessionsPlayed.ToString();
                    tr.Cells.Add(games);

                    TableCell kda = new TableCell();
                    kda.Text = Math.Round(((double) (cs.Stats.TotalChampionKills + cs.Stats.TotalAssists) / cs.Stats.TotalDeathsPerSession), 2).ToString();
                    tr.Cells.Add(kda);

                    TableCell kills = new TableCell();
                    kills.Text = cs.Stats.TotalChampionKills.ToString();
                    tr.Cells.Add(kills);

                    TableCell deaths = new TableCell();
                    deaths.Text = cs.Stats.TotalDeathsPerSession.ToString();
                    tr.Cells.Add(deaths);

                    TableCell assists = new TableCell();
                    assists.Text = cs.Stats.TotalAssists.ToString();
                    tr.Cells.Add(assists);

                    ChampionsTable.Rows.Add(tr);
                }
                if (cs.ChampionId == 0)
                {
                    totalSessionsPlayed = cs.Stats.TotalSessionsPlayed;
                }
            }
            BadgeImage.ImageUrl = "img/badges/" + leagueInfo[0].Tier.ToString().ToUpper() + "_" + leagueInfo[0].Entries[0].Division + ".png";
            TierDivisionLabel.Text = leagueInfo[0].Tier + " " + leagueInfo[0].Entries[0].Division;
            LeaguePointsLabel.Text = leagueInfo[0].Entries[0].LeaguePoints + " LP";
            GamesWinsLossesLabel.Text = totalSessionsPlayed + "G " + leagueInfo[0].Entries[0].Wins + "W " + (totalSessionsPlayed - leagueInfo[0].Entries[0].Wins) + "L";
            
            WinRatioLabel.Text = Math.Round(((double)leagueInfo[0].Entries[0].Wins / (double)totalSessionsPlayed), 2) * 100 + "%";
        }

        protected void SummonerSearchButton_Click(object sender, EventArgs e)
        {
            ErrorPanel.Visible = false;
            LeagueInfoUpdatePanel.Visible = true;
            
            
            try
            {
                Summoner summoner = da.getSummonerByName(SummonerSearchTextBox.Text, Int32.Parse(regionSelect.Value));
                List<ChampionStats> championStats = summoner.GetStatsRanked();
                List<League> leagueInfo = summoner.GetLeagues();
                generateSummonerPage(summoner, championStats, leagueInfo);
                Thread.Sleep(1500);
                LeagueInfoPanel.Visible = true;
                ChampionsTable.Visible = true;
                
            }
            catch (RiotSharpException ex)
            {
                ErrorPanelLabel.Text = ex.Message;
                Thread.Sleep(1200);
                ErrorPanel.Visible = true;
                LeagueInfoUpdatePanel.Visible = false;

            }
        }

        //[WebMethod]
        //[ScriptMethod]
        //public void FindSummoner()
        //{
        //    ErrorPanel.Visible = false;
        //    try
        //    {
        //        Summoner summoner = da.getSummonerByName(SummonerSearchTextBox.Text, Int32.Parse(regionSelect.Value));
        //        List<ChampionStats> championStats = summoner.GetStatsRanked();
        //        List<League> leagueInfo = summoner.GetLeagues();
        //        generateSummonerPage(summoner, championStats, leagueInfo);
        //        LeagueInfoUpdatePanel.Update();
        //    }
        //    catch (RiotSharpException ex)
        //    {
        //        ErrorPanelLabel.Text = ex.Message;
        //        ErrorPanel.Visible = true;

        //    }
        //}
    }
}