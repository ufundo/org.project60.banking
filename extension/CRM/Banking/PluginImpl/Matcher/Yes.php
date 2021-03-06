<?php
/*-------------------------------------------------------+
| Project 60 - CiviBanking                               |
| Copyright (C) 2013-2018 SYSTOPIA                       |
| Author: B. Endres (endres -at- systopia.de)            |
| http://www.systopia.de/                                |
+--------------------------------------------------------+
| This program is released as free software under the    |
| Affero GPL v3 license. You can redistribute it and/or  |
| modify it under the terms of this license which you    |
| can read by viewing the included agpl.txt or online    |
| at www.gnu.org/licenses/agpl.html. Removal of this     |
| copyright header is strictly prohibited without        |
| written permission from the original author(s).        |
+--------------------------------------------------------*/


/**
 * This is a dummy matcher for testing purposes only
 */
class CRM_Banking_PluginImpl_Matcher_Yes extends CRM_Banking_PluginModel_Matcher {

  /**
   * class constructor
   */
  function __construct($config_name) {
    parent::__construct($config_name);
  }

  public function match(CRM_Banking_BAO_BankTransaction $btx, CRM_Banking_Matcher_Context $context) {
    $suggestion = new CRM_Banking_Matcher_Suggestion($this, $btx);
    $suggestion->addEvidence( 1.0, "Yes we can" );
    return array($suggestion);
  }

  /**
   * Handle the different actions, should probably be handles at base class level ...
   * 
   * @param type $match
   * @param type $btx
   */
  public function execute($match, $btx) {
    
  }

  public function visualize_match(CRM_Banking_Matcher_Suggestion $match, $btx) {
    return '<div style="background-color:gray;text-align:center">
            <font size="+1">
            <font color="#ccff66">Y</font>
            <font color="#84ed42">E</font>
            <font color="#54e12a">S</font>
            <font color="#3cdb1e">!</font>
            <font color="#24d512">!</font>
            <font color="#0ccf06">!</font>
            </font>
            </div>';
  }

  /** 
   * Generate html code to visualize the executed match.
   * 
   * @val $match    match data as previously generated by this plugin instance
   * @val $btx      the bank transaction the match refers to
   * @return html code snippet
   */  
  function visualize_execution_info( CRM_Banking_Matcher_Suggestion $match, $btx) {
    return "<p>Why? Because.</p>";
  }

}


