<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="lolvoid_asp2.home" Async="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home - LolVoid</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        $(document).ready(function () {
            $('.selectpicker').selectpicker();
            $("table").tablecloth({
                theme: "default",
                bordered: true,
                condensed: true,
                striped: true,
                sortable: true,
                clean: true,
                cleanElements: "th td"
            });
        });

    </script>
    <div class="container">
        <div class="input-group">
            <div class="input-group-btn search-panel">
                <select id="regionSelect" runat="server" class="selectpicker" data-width="100px">
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
                <asp:Button ID="SummonerSearchButton" runat="server" CssClass="btn btn-default" Text="Search" OnClick="SummonerSearchButton_Click"></asp:Button>
            </span>
        </div>
        <asp:Panel ID="ErrorPanel" runat="server" CssClass="alert alert-danger" role="alert" Visible="false">
            <asp:Label ID="ErrorPanelLabel" runat="server"></asp:Label></asp:Panel>


        <h1>
            <asp:Label ID="SummonerIdLabel" runat="server" Text="Label"></asp:Label></h1>
        <h1>
            <asp:Label ID="SummonerNameLabel" runat="server" Text="Label"></asp:Label></h1>
        <h1>
            <asp:Label ID="SummonerLevelLabel" runat="server" Text="Label"></asp:Label></h1>
        <h1>
            <asp:Label ID="SummonerProfileIconIdLabel" runat="server" Text="Label"></asp:Label></h1>
        <h1>
            <asp:Label ID="SummonerRegionLabel" runat="server" Text="Label"></asp:Label></h1>

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
        <asp:Table ID="ChampionsTable" runat="server" CssClass="table table-hover table-bordered table-striped table-scrollable table-responsive">
            <asp:TableHeaderRow runat="server">
                <asp:TableHeaderCell Scope="Column" Text="Champion"/>
                <asp:TableHeaderCell Scope="Column" Text="Games"/>
                <asp:TableHeaderCell Scope="Column" Text="K/D/A"/>
                <asp:TableHeaderCell Scope="Column" Text="Kills"/>
                <asp:TableHeaderCell Scope="Column" Text="Deaths"/>
                <asp:TableHeaderCell Scope="Column" Text="Assists"/>
            </asp:TableHeaderRow>
        </asp:Table>
    </div>
</asp:Content>
