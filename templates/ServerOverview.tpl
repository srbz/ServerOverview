{include file='documentHeader'}
<head>
	<title>Teamspeak Viewer - {lang}{PAGE_TITLE}{/lang}</title> 
	{include file='headInclude' sandbox=false}
</head>
<body>
	{include file='header' sandbox=false} 
	<div id="main">
		<ul class="breadCrumbs">
			<li><a href="index.php{@SID_ARG_1ST}"><img src="{icon}indexS.png{/icon}" alt="" /> <span>{lang}{PAGE_TITLE}{/lang}</span></a> &raquo;</li>
		</ul> 

		<div class="mainHeadline">
			<img src="{icon}seiteL.png{/icon}" alt="" /> 
			<div class="headlineContainer">
				<h2>Teamspeak Viewer</h2> 
				<p></p>
			</div>
		</div>
		{if $userMessages|isset}{@$userMessages}{/if}
		
        {* content div *}
        <div class="border content">
            <div class="container-1">
                Hallo Liebe Welt.
            </div>
        </div>
	</div>
	{include file='footer' sandbox=false} 
</body>
</html>