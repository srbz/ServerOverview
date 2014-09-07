<?php
// wcf imports
require_once(WCF_DIR.'lib/page/AbstractPage.class.php');
// util imports
require_once(WCF_DIR.'lib/util/GameQ/GameQ.php');
require_once(WCF_DIR.'lib/util/StringStack.class.php');
require_once(WCF_DIR.'lib/util/HeaderUtil.class.php');
/**
 * Just an example page
 *
 * @author    zerocool
 * @copyright    2013 sexygaming.de
 * @package    de.sexygaming.serveroverview
 * @license    insert it here
 */
class ServerOverviewPage extends AbstractPage {
    // ServerOverview.tpl
    public $templateName = 'serverOverview';

    protected $gameqData     = array();
    protected $fullPathArray = array();

    /**
     * Parses and translates the Quake3 Color Codes into html
     *
     * @param string $name name with q3 color codes
     *
     * @return string String with span-html which contains the color
     */
    public function parseQuake3ColorCodes($name) {
        $colorMapping = array(
            '~' => '#00007F',
            '!' => '#FF9919',
            '@' => '#7F3F00',
            '#' => '#7F007F',
            '$' => '#007FFF',
            '%' => '#7F00FF',
            '&' => '#3399CC',
            '*' => '#CCC', //FFFFFF
            '(' => '#006633',
            ')' => '#FF0033',
            '_' => '#7F0000',
            '+' => '#993300',
            '|' => '#007F00',
            '`' => '#7F3F00',
            '1' => '#FF0000',
            '2' => '#00FF00',
            '3' => '#FFFF00',
            '4' => '#0000FF',
            '5' => '#00FFFF',
            '6' => '#FF00FF',
            '7' => '#CCC', //FFFFFF
            '8' => '#FF7F00',
            '9' => '#7F7F7F',
            '0' => '#000000',
            '-' => '#999933',
            '=' => '#7F7F00',
            '\\' => '#007F00',
            'Q' => '#FF0000',
            'W' => '#CCC', //FFFFFF
            'E' => '#7F00FF',
            'R' => '#00FF00',
            'T' => '#0000FF',
            'Y' => '#7F7F7F',
            'U' => '#00FFFF',
            'I' => '#FF0033',
            'O' => '#FFFF7F',
            'P' => '#000000',
            '[' => '#BFBFBF',
            ']' => '#7F7F00',
            '{' => '#BFBFBF',
            '}' => '#7F7F00',
            'A' => '#FF9919',
            'S' => '#FFFF00',
            'D' => '#007FFF',
            'F' => '#3399CC',
            'G' => '#CCFFCC',
            'H' => '#006633',
            'J' => '#B21919',
            'K' => '#993300',
            'L' => '#CC9933',
            ';' => '#BFBFBF',
            '\'' => '#CCFFCC',
            ':' => '#BFBFBF',
            'Z' => '#BFBFBF',
            'X' => '#FF7F00',
            'C' => '#7F007F',
            'V' => '#FF00FF',
            'B' => '#007F7F',
            'N' => '#FFFFBF',
            'M' => '#999933',
            ',' => '#CC9933',
            '.' => '#FFFFBF',
            '/' => '#FFFF7F',
            '<' => '#007F00',
            '>' => '#00007F',
            '?' => '#7F0000',
        );

        $color = '<span class="player"><span style="#ccc">';
        for($i = 0; $i < strlen($name); $i++)
        {
            if($name[$i] == '^')
            {
                $colorCode = isset($colorMapping[strtoupper($name[$i+1])]) ? $colorMapping[strtoupper($name[$i+1])] : '#ccc';
                $color    .= '</span><span style="color: '.$colorCode.'">';
                $i++; continue;
            }

            $color .= $name[$i];
        }

        $color .= '</span></span>';
        return $color;
    }

    /**
	 * @see AbstractPage::readParameters()
	 */
    public function readParameters() {
        parent::readParameters();
    }

    /**
	 * @see AbstractPage::readData()
	 */
    public function readData() {
        parent::readData();
        //create the GameQ class
        $gq = new GameQ();

        $gq->setFilter('normalise');

        //add teamspeak server
        $gq->addServer(array(
            'id' => 'ts3',
            'type' => 'teamspeak3',
            'host' => 'sexygaming.de',
        ));
        //add et trickjump server
        $gq->addServer(array(
            'id' => 'ettj',
            'type' => 'et',
            'host' => 'sexygaming.de:27960',
        ));
        //add et privatejump server
        $gq->addServer(array(
            'id' => 'ettjpriv',
            'type' => 'et',
            'host' => 'sexygaming.de:27965',
        ));
        //add et xmas server
        $gq->addServer(array(
            'id' => 'etpro',
            'type' => 'et',
            'host' => 'sexygaming.de:27980',
        ));

        //request resultset
        $data = $gq->requestData();
        $data = array_filter($data, function($entry){
            return isset($entry['gq_hostname']) && $entry['gq_hostname'];
        });

        $fullPathArray = array();
        if(isset($data['ts3']) && isset($data['ts3']['teams']) && !empty($data['ts3']['teams']))
        {
            foreach($data['ts3']['teams'] as $team)
            {
                $fullName = $team['gq_name'];
                $parent = intval($team['pid']);
                while($parent != 0)
                {
                    $parent = $data['ts3']['teams'][$parent];

                    $fullName = $parent['gq_name'].' > '.$fullName;

                    $parent = $parent['pid'];
                }
		$fullName = preg_replace('(\[(l|c|r)spacer\])', '', $fullName);
                $fullPathArray[$team['cid']] = $fullName;
            }
        }

        foreach($data as $serverType => $serverData){
            if($serverData['gq_protocol'] === 'quake3')
            {
                $data[$serverType]['sv_hostname'] = $this->parseQuake3ColorCodes($data[$serverType]['sv_hostname']);
                if(isset($data[$serverType]['players'])){
                    foreach($data[$serverType]['players'] as $k => $player){
                        $data[$serverType]['players'][$k]['name'] = $this->parseQuake3ColorCodes($player['name']);
                    }
                }
            }
            if($serverData['gq_protocol'] === 'teamspeak3')
            {
                if(isset($serverData['players']))
                {
                    usort($data[$serverType]['players'], function($a, $b) use ($fullPathArray) { return $fullPathArray[$a['cid']] < $fullPathArray[$b['cid']]; });
                }
            }
        }


        $this->fullPathArray = $fullPathArray;
        $this->gameqData     = $data;
    }

	/**
	 * @see AbstractPage::assignVariables()
	 */
    public function assignVariables() {
        parent::assignVariables();

        WCF::getTPL()->assign(array(
            'results' => $this->gameqData,
            'full_path_array' => $this->fullPathArray
        ));
    }

    /**
	 * @see AbstractPage::show()
	 */
    public function show() {
        require_once(WCF_DIR . 'lib/page/util/menu/PageMenu.class.php');
        PageMenu::setActiveMenuItem('Serverübersicht');
        parent::show();
    }
}
