<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="lolvoid_asp2.home" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home - LolVoid</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        $(document).ready(function () {
            $('.selectpicker').selectpicker();
            $('.js-loading-bar').modal({
                backdrop: 'static',
                show: false
            });
        });

        function duringUpdate() {
            $('#myModal').modal();
        }


        function afterUpdate() {
            $('.tablesorter').tablesorter();
            $('#logoImage').animate({ marginTop: '-100px', marginBottom: '-50', opacity: '0' }, 1000);
            $('#myModal').modal('hide');
        }



    </script>
    <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" />
    <ajaxToolkit:UpdatePanelAnimationExtender BehaviorID="leagueInfoAnimation" ID="UpdatePanelAnimationExtender1" runat="server"
        TargetControlID="LeagueInfoUpdatePanel">
        <Animations>
            <OnUpdating>
                <FadeOut duration=".25" fps="30"></FadeOut>
            </OnUpdating>
            <OnUpdated>
                <FadeIn duration=".25" fps="30"></FadeIn>
            </OnUpdated>
        </Animations>
    </ajaxToolkit:UpdatePanelAnimationExtender>
    <ajaxToolkit:UpdatePanelAnimationExtender BehaviorID="buttonAnimation" ID="UpdatePanelAnimationExtender2" runat="server"
        TargetControlID="SummonerSearchButtonUpdatePanel">
        <Animations>
            <OnUpdating>
                <ScriptAction script="duringUpdate();"></ScriptAction>
            </OnUpdating>
            <OnUpdated>
                <ScriptAction script="afterUpdate();"></ScriptAction>
            </OnUpdated>
        </Animations>
    </ajaxToolkit:UpdatePanelAnimationExtender>
    <div class="container">
        <img id="logoImage" src="http://placehold.it/350x150" class="img-responsive center-block" alt="Responsive image" style="margin-top: 100px; margin-bottom: 50px;" />
        <div class="input-group">
            <div class="input-group-btn search-panel">
                <select id="regionSelect" runat="server" class="selectpicker" data-width="100%">
                    <option value="3">NA</option>
                    <option value="2">EUW</option>
                    <option data-divider="true"></option>
                    <option value="0">BR</option>
                    <option value="1">EUNE</option>
                    <option value="4">KR</option>
                    <option value="5">LAN</option>
                    <option value="6">LAS</option>
                    <option value="7">OCE</option>
                    <option value="8">RU</option>
                    <option value="9">TR</option>
                </select>
            </div>
            <asp:TextBox ID="SummonerSearchTextBox" runat="server" CssClass="form-control" placeholder="Summoner Name"></asp:TextBox>
            <span class="input-group-btn">
                <asp:UpdatePanel ID="SummonerSearchButtonUpdatePanel" runat="server">
                    <ContentTemplate>
                        <asp:Button runat="server" CssClass="btn btn-default" OnClick="SummonerSearchButton_Click" Text="Search"></asp:Button>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </span>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">Loading Summoner Data...</h4>
                    </div>
                    <div class="modal-body">
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped active" style="width: 100%;">
                                <span class="sr-only">100% Complete</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="ErrorUpdatePanel" runat="server">
            <ContentTemplate>
                <asp:Panel ID="ErrorPanel" runat="server" CssClass="alert alert-danger" role="alert" Visible="false">
                    <asp:Label ID="ErrorPanelLabel" runat="server"></asp:Label>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="LeagueInfoUpdatePanel" runat="server" UpdateMode="Always">
            <ContentTemplate>

                <asp:Panel ID="LeagueInfoPanel" runat="server" CssClass="well" Visible="false">
                    <div class="row">
                        <div class="content">
                            <div class="col-xs-6 responsive-font">
                                <asp:Label ID="SummonerProfileIconIdLabel" runat="server"></asp:Label>
                            </div>
                            <div class="col-xs-6 responsive-font">
                                <h2>
                                    <asp:Label ID="SummonerNameLabel" runat="server"></asp:Label></h2>
                            </div>

                        </div>
                        <div class="content">
                            <div class="col-xs-6 responsive-font">
                                <asp:Image ID="BadgeImage" runat="server" CssClass="img-responsive" />
                            </div>
                            <div class="col-xs-6 responsive-font" style="height: 100%;">
                                <p style="color: lightseagreen">
                                    <asp:Label ID="TierDivisionLabel" runat="server"></asp:Label>
                                </p>
                                <p>
                                    <asp:Label ID="LeaguePointsLabel" runat="server"></asp:Label>
                                </p>
                                <p>
                                    <asp:Label ID="GamesWinsLossesLabel" runat="server"></asp:Label>
                                </p>
                                <p>
                                    <asp:Label ID="WinRatioLabel" runat="server"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </asp:Panel>



                <%--<table id="championsTable" class="table table-hover table-bordered table-striped tablesorter-bootstrap table-scrollable table-responsive">
            <thead>
                <tr>
                    <th class="tablesorter-header">Champion</th>
                    <th class="tablesorter-header">Games</th>
                    <th class="tablesorter-header">K/D/A</th>
                    <th class="tablesorter-header">Kills</th>
                    <th class="tablesorter-header">Deaths</th>
                    <th class="tablesorter-header">Assists</th>
                </tr>
            </thead>
            <tbody>

            </tbody>
        </table>--%>


                <asp:Table Visible="false" ID="ChampionsTable" runat="server" CssClass="table table-hover table-bordered table-striped table-scrollable table-responsive tablesorter">
                    <asp:TableHeaderRow runat="server" TableSection="TableHeader">
                        <asp:TableHeaderCell Scope="Column" Text="Champion" />
                        <asp:TableHeaderCell Scope="Column" Text="Games" />
                        <asp:TableHeaderCell Scope="Column" Text="K/D/A" />
                        <asp:TableHeaderCell Scope="Column" Text="Kills" />
                        <asp:TableHeaderCell Scope="Column" Text="Deaths" />
                        <asp:TableHeaderCell Scope="Column" Text="Assists" />
                    </asp:TableHeaderRow>
                </asp:Table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
