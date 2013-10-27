{include file='documentHeader'}
<head>
	<title>Server Overviewe - {lang}{PAGE_TITLE}{/lang}</title> 
	{include file='headInclude' sandbox=false}
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
				<h2>Server Overview</h2> 
				<p>{$results|count} Server online</p>
			</div>
		</div>
		{if $userMessages|isset}{@$userMessages}{/if}
		
        {* content div *}
        <div class="border content">
            <div class="container-1">
            <h2><a href="ts3://{$results.ts3.gq_address}:{$results.ts3.virtualserver_port}">{$results.ts3.virtualserver_name}</a></h2>
                <div class="container-1" style="margin-top:15px;">
                    <div class="container-1"  style="width: 30%;float: left">
                        Online: {$results.ts3.virtualserver_clientsonline} / {$results.ts3.virtualserver_maxclients}
                        <br>
                        <p>
                            <a href="ts3://{$results.ts3.gq_address}:{$results.ts3.virtualserver_port}">
                            Verbinden mit Server
                            </a>
                        </p>
                    </div>
                    <div class="container-1" style="width: 50%;float: left;height: 250px;overflow-y: scroll;">
                        <table style="width: 100%">
                        <tr style="text-align: left;">
                            <th>Name</th>
                            <th>Channel</th>
                        </tr>
                            {if $results.ts3.players|count > 0}
                            {foreach from=$results.ts3.players item=$player}
                                {foreach from=$results.ts3.teams item=$team}
                                    {if $team.cid == $player.cid}
                                        <tr style="background-color: {cycle values="#eee ,#fff"}">
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
            </div>
            <div class="container-1">
            <h2><a href="hlsw://{$results.ettj.gq_address}:{$results.ettj.gq_port}">{@$results.ettj.sv_hostname}</a></h2>
                <div class="container-1" style="margin-top:15px;">
                    <div class="container-1"  style="width: 30%;float: left">
                        <img src="http://et.splatterladder.com/levelshots/et/{$results.ettj.mapname}.jpg" alt="" /><br/>
                        <p>
                        Map: {$results.ettj.mapname}
                        </p>
                        <p>
                        Online: {$results.ettj.num_players} / {$results.ettj.sv_maxclients}
                        </p>
                        <p>
                            <a href="hlsw://{$results.ettj.gq_address}:{$results.ettj.gq_port}">
                            Verbinden mit Server
                            </a>
                        </p>
                    </div>
                    <div class="container-1" style="width: 50%;float: left;height: 250px;overflow-y: scroll;">
                        <table style="width: 100%">
                        <tr style="text-align: left;">
                            <th>Name</th>
                            <th>Punkte</th>
                            <th>Ping</th>
                        </tr>
                            {if $results.ettj.num_players|count > 0}
                            {foreach from=$results.ettj.players item=$player}
                                <tr style="background-color: {cycle values="#eee ,#fff"}">
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
            </div>
            <div class="container-1">
            <h2><a href="hlsw://{$results.ettjpriv.gq_address}:{$results.ettjpriv.gq_port}">{@$results.ettjpriv.sv_hostname}</a></h2>
                <div class="container-1" style="margin-top:15px;">
                    <div class="container-1"  style="width: 30%;float: left">
                        <img src="http://et.splatterladder.com/levelshots/et/{$results.ettjpriv.mapname}.jpg" alt="" /><br/>
                        <p>
                        Map: {$results.ettjpriv.mapname}
                        </p>
                        <p>
                        Online: {$results.ettjpriv.num_players} / {$results.ettjpriv.sv_maxclients}
                        </p>
                        <p>
                            <a href="hlsw://{$results.ettjpriv.gq_address}:{$results.ettjpriv.gq_port}">
                            Verbinden mit Server
                            </a>
                        </p>
                    </div>
                    <div class="container-1" style="width: 50%;float: left;height: 250px;overflow-y: scroll;">
                        <table style="width: 100%">
                        <tr style="text-align: left;">
                            <th>Name</th>
                            <th>Punkte</th>
                            <th>Ping</th>
                        </tr>
                            {if $results.ettjpriv.num_players|count > 0}
                            {foreach from=$results.ettjpriv.players item=$player}
                                <tr style="background-color: {cycle values="#eee ,#fff"}">
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
            </div>
        </div>
	</div>
	{include file='footer' sandbox=false} 
</body>
</html>