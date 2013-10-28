{include file='documentHeader'}
<head>
	<title>Serverübersichts - {lang}{PAGE_TITLE}{/lang}</title>
	{include file='headInclude' sandbox=false}
    <style>

        .server{
            margin-top: 15px;
        }
        .serverInfos{
            width: 30%;
            float: left
        }
        .serverPlayers{
            width: 65%;
            float: left;
            height: 250px;
            overflow-y: scroll;
        }

        .server table{
            width: 100%;
        }
        .server tr.odd{
            background-color: #fff;
        }
        .server tr.even{
            background-color: #eee;
        }
        .server th{
            text-align: left;
        }
    </style>
</head>
<body>
	{include file='header' sandbox=false} 
	<div id="main">
		<ul class="breadCrumbs">
			<li><a href="index.php{@SID_ARG_1ST}"><span>{lang}{PAGE_TITLE}{/lang}</span></a> &raquo;</li>
		</ul> 

		<div class="mainHeadline">
			<img src="{icon}updateServerL.png{/icon}" alt="" /> 
			<div class="headlineContainer">
				<h2>Serverübersicht</h2> 
				<!--<p>{$results|count} Server</p>-->
			</div>
		</div>
		{if $userMessages|isset}{@$userMessages}{/if}

        {foreach from=$results key='protocol' item='serverData'}
            {if $serverData.gq_protocol|isset}
            <div class="border content">
                <div class="container-1">
                    {if $serverData.gq_protocol === 'quake3'}
                        <h2><a href="hlsw://{$serverData.gq_address}:{$serverData.gq_port}">{@$serverData.sv_hostname}</a></h2>
                        <div class="container-1 server">
                            <div class="container-1 serverInfos">
                                <img src="http://et.splatterladder.com/levelshots/et/{$serverData.mapname}.jpg" alt="" /><br/>
                                <p>
                                    Map: {$serverData.mapname}
                                </p>
                                <p>
                                    Online: {$serverData.num_players} / {$serverData.sv_maxclients}
                                </p>
                                <p>
                                    <a href="hlsw://{$serverData.gq_address}:{$serverData.gq_port}">
                                        Verbinden mit Server
                                    </a>
                                </p>
                            </div>
                            <div class="container-1 serverPlayers">
                                <table>
                                    <tr>
                                        <th>Name</th>
                                        <th>Punkte</th>
                                        <th>Ping</th>
                                    </tr>
                                    {if $serverData.num_players > 0}
                                        {* reset cycle *}
                                        {cycle values="even ,odd" reset=yes print=false}
                                        {foreach from=$serverData.players item=$player}
                                            <tr class="{cycle values="even ,odd"}">
                                                <td>{@$player.name}</td>
                                                <td>{@$player.frags}</td>
                                                <td>{if $player.ping}{@$player.ping}{else}BOT{/if}</td>
                                            </tr>
                                        {/foreach}
                                    {else}
                                        <tr>
                                            <td colspan="3"><h2>Niemand online.</h2></td>
                                        </tr>
                                    {/if}
                                </table>
                            </div>
                            <div style="clear: both"></div>
                        </div>
                    {elseif $serverData.gq_protocol === 'teamspeak3'}
                        <h2><a href="ts3://{$serverData.gq_address}:{$serverData.virtualserver_port}">{$serverData.virtualserver_name}</a></h2>
                        <div class="container-1 server">
                            <div class="container-1 serverInfos">
                                Online: {$serverData.players|count} / {$serverData.virtualserver_maxclients}
                                <br>
                                <p>
                                    <a href="ts3://{$serverData.gq_address}:{$serverData.virtualserver_port}">
                                        Verbinden mit Server
                                    </a>
                                </p>
                            </div>
                            <div class="container-1 serverPlayers">
                                <table>
                                    <tr>
                                        <th>Name</th>
                                        <th>Channel</th>
                                    </tr>
                                    {if $serverData.players|count > 0}
                                        {* reset cycle *}
                                        {cycle values="even ,odd" reset=yes print=false}
                                        {foreach from=$serverData.players item=$player}
                                            {foreach from=$serverData.teams item=$team}
                                                {if $team.cid == $player.cid}
                                                    <tr class="{cycle values="even ,odd"}">
                                                        <td>{@$player.client_nickname}</td>
                                                        <td>{@$team.channel_name}</td>
                                                    </tr>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    {else}
                                        <tr>
                                            <td colspan="3"><h2>Niemand online.</h2></td>
                                        </tr>
                                    {/if}
                                </table>
                            </div>
                            <div style="clear: both"></div>
                        </div>
                    {else}
                        Es wurde noch kein Template für '{$serverData.gq_protocol}' definiert.
                    {/if}
                </div>
            </div>
            {/if}
        {/foreach}
	</div>
	{include file='footer' sandbox=false} 
    <script>
    (function(){
        var allimgs = document.images;
        
        for(var i=0; i<allimgs.length; i++){
            allimgs[i].onerror = function () {
                this.style.visibility = "hidden"; // other elements not affected 
            }
        }
    })();
    </script>
</body>
</html>
