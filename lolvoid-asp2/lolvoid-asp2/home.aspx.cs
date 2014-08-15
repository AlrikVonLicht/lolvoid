using lolvoid_asp2.data_access;
using RiotSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
        protected void generateSummonerPage(Summoner sum, List<ChampionStats> champStats)
        {
            SummonerIdLabel.Text = sum.Id.ToString();
            SummonerNameLabel.Text = sum.Name;
            SummonerLevelLabel.Text = sum.Level.ToString();
            SummonerProfileIconIdLabel.Text = sum.ProfileIconId.ToString();
            SummonerRegionLabel.Text = sum.Region.ToString();
            foreach(ChampionStats cs in champStats){
                if (cs.ChampionId != 0)
                {
                    TableRow tr = new TableRow();
                    TableCell champion = new TableCell();
                    champion.Text = cs.ChampionId.ToString();
                    tr.Cells.Add(champion);

                    TableCell games = new TableCell();
                    games.Text = cs.Stats.TotalSessionsPlayed.ToString();
                    tr.Cells.Add(games);

                    TableCell kda = new TableCell();
                    kda.Text = ((cs.Stats.TotalChampionKills + cs.Stats.TotalAssists) / cs.Stats.TotalDeathsPerSession).ToString();
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
            }
        }

        protected void SummonerSearchButton_Click(object sender, EventArgs e)
        {
            ErrorPanel.Visible = false;
            try
            {
                Summoner summoner = da.getSummonerByName(SummonerSearchTextBox.Text, Int32.Parse(regionSelect.Value));
                List<ChampionStats> championStats = summoner.GetStatsRanked();
                generateSummonerPage(summoner, championStats);
                
            }
            catch (RiotSharpException ex)
            {
                ErrorPanelLabel.Text = ex.Message;
                ErrorPanel.Visible = true;

            }
        }
    }
}