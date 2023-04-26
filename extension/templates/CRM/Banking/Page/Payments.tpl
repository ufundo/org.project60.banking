{*-------------------------------------------------------+
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
+--------------------------------------------------------*}

{literal}<style>
.status_New {
  color: red;
  font-weight: bold;
  text-transform: uppercase;
  text-align: center;
  vertical-align: middle;
  }
.unknown {
  color: red;
  }
</style>{/literal}

{* This page is generated by CRM/Banking/Page/Payments.php *}

<div>
<a class="button" href="{$url_show_payments_new}">
  <span style="{$button_style_new}"><div class="crm-i fa-star"></div> {ts domain='org.project60.banking'}New{/ts} ({$count_new})</span>
</a>
<a class="button" href="{$url_show_payments_analysed}">
  <span style="{$button_style_analysed}"><div class="crm-i fa-star-o"></div> {ts domain='org.project60.banking'}Analysed{/ts} ({$count_analysed})</span>
</a>
{if $url_show_payments_recently_completed and $show == 'statements'}
<a class="button" href="{$url_show_payments_recently_completed}">
  <span style="{$button_style_recently_completed}"><div class="crm-i fa-check-circle-o"></div> {ts domain='org.project60.banking'}Completed (Recent){/ts} ({$count_recently_completed})</span>
</a>
{/if}
<a class="button" href="{$url_show_payments_completed}">
  <span style="{$button_style_completed}"><div class="crm-i fa-check-circle"></div> {ts domain='org.project60.banking'}Completed{/ts} ({$count_completed})</span>
</a>
{if $show == 'payments'}
  <a class="button" href="{$url_show_statements}" style="float: right;">
    <span><div class="crm-i fa-list"></div> {ts domain='org.project60.banking'}Show Statements{/ts}</span>
  </a>
{else}
  <a class="button" onClick="callWithSelected('{$url_show_payments}', true)" style="float: right;">
    <span><div class="crm-i fa-list"></div> {ts domain='org.project60.banking'}Show Transactions{/ts}</span>
  </a>
{/if}
</div>
<br/><br/>
<h3>Status: {$status_message}</h3>

<form action="" method="post">
  {ts domain='org.project60.banking'}Showing statements for{/ts}
  <select name="target_ba_id">
    <option value="">{ts domain='org.project60.banking'}all accounts{/ts}</option>
    {foreach from=$target_accounts item=ba_name key=ba_id}
      <option value="{$ba_id}" {if $ba_id == $target_ba_id}selected="selected"{/if}>{$ba_name}</option>
    {/foreach}
  </select>
  <button type="submit">{ts domain='org.project60.banking'}Filter{/ts}</button>
</form>
<br/>

{if not $rows}    {* NO ROWS FOUND *}
  {if $show=='payments'}
    <div id="help" class="description">
      {ts domain='org.project60.banking'}No transactions could be found with the requested status. Try the other status filter buttons above to find your imported payments.{/ts}
    </div>
  {else}
    <div id="help" class="description">
      {ts domain='org.project60.banking'}No statments could be found with the requested status. Try the other status filter buttons above to find your imported statements.{/ts}
    </div>
  {/if}
{else}            {* ROWS FOUND -> CREATE TABLE *}

<table id="contact-activity-selector-dashlet">
{if $show=='payments'}
<thead>
	<tr>
		<th colspan="1" rowspan="1" class="ui-state-default">
			<div class="DataTables_sort_wrapper"><input type="checkbox" id="banking_selector"><span class="DataTables_sort_icon"></span></div>
		</th>
		<th colspan="1" rowspan="1" class="crm-banking-payment_date ui-state-default">
			<div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Date{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
		</th>
		<th colspan="1" rowspan="1" class="crm-banking-payment_target_owner ui-state-default">
			<div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Account{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
		</th>
		<th colspan="1" rowspan="1" class="crm-banking-payment_target_owner ui-state-default">
			<div class="DataTables_sort_wrapper">#<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
		</th>
		<th colspan="1" rowspan="1" class="crm-banking-payment_amount ui-state-default">
			<div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Amount{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
		</th>
		<th colspan="1" rowspan="1" class="crm-banking-payment_source_account nosort ui-state-default">
			<div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Party{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
		</th>
		<th colspan="1" rowspan="1" class="ccrm-banking-payment_state ui-state-default">
			<div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Status{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
		</th>
    <th colspan="1" rowspan="1" class="ui-state-default">
      <div class="DataTables_sort_wrapper"><span></span></div>
    </th>
		<th colspan="1" rowspan="1" class="hiddenElement ui-state-default">
			<div class="DataTables_sort_wrapper">&nbsp;<span class="DataTables_sort_icon"></span></div>
		</th>
	</tr>
</thead>
<tbody>
  {foreach from=$rows item=field key=fieldName}
  <tr class="odd ">
    <td><input id="check_{$field.id}" type="checkbox" name="payment_selected" onClick="cj('#banking_selector').attr('checked',false);"></td>
    <td class="" nowrap>{$field.date|date_format:"%d-%m-%Y"}</td>
    <td class="">{$field.account_owner}</td>
    <td class="" style="text-align: center;">{$field.sequence}</td>
    <td class="" style="text-align: right;">{$field.amount} {$field.currency}</td>
    <td class="">
      {if $field.party_contact}
        <a href="{$base_url}/civicrm/contact/view?reset=1&cid={$field.party_contact.id}">{$field.party_contact.display_name}</a>
      {else}
        <span class="unknown">{$field.party}</span>
      {/if}
      {if $field.payment_data_parsed.purpose}
        <br/>
        <span style="color: #ccc;">{$field.payment_data_parsed.purpose}</span>
      {/if}
    </td>
    <td class="status_{$field.state}">
      {$field.state}
    </td>
    <td class=""><a href="{$field.url_link}">{ts domain='org.project60.banking'}view{/ts}</a></td>
    <td class="hiddenElement">status-overdue</td>
  </tr>
  {/foreach}
</tbody>

{else} {* STATEMENTS *}
<thead>
  <tr>
    <th colspan="1" rowspan="1" class="ui-state-default">
      <div class="DataTables_sort_wrapper"><input type="checkbox" id="banking_selector"><span class="DataTables_sort_icon"></span></div>
    </th>
    <th colspan="1" rowspan="1" class="crm-banking-payment_date ui-state-default">
      <div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Date{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
    </th>
    <th colspan="1" rowspan="1" class="ccrm-banking-payment_target_account nosort ui-state-default">
      <div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Target Account{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
    </th>
    <th colspan="1" rowspan="1" class="crm-banking-payment_date ui-state-default">
      <div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Statement{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
    </th>
    <th colspan="1" rowspan="1" class="crm-banking-payment_amount ui-state-default">
      <div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Transaction count{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
    </th>
    <th colspan="1" rowspan="1" class="crm-banking-payment_source_account nosort ui-state-default">
      <div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Analysed{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
    </th>
    <th colspan="1" rowspan="1" class="crm-banking-payment_source_account nosort ui-state-default">
      <div class="DataTables_sort_wrapper">{ts domain='org.project60.banking'}Completed{/ts}<!--span class="DataTables_sort_icon css_right ui-icon ui-icon-carat-2-n-s"></span--></div>
    </th>
    <th colspan="1" rowspan="1" class="hiddenElement ui-state-default">
      <div class="DataTables_sort_wrapper">&nbsp;<!--span class="DataTables_sort_icon"></span--></div>
    </th>
  </tr>
</thead>
<tbody>
  {foreach from=$rows item=field key=fieldName}
  <tr class="odd ">
    <td><input id="check_{$field.id}" type="checkbox" name="payment_selected" onClick="cj('#banking_selector').attr('checked',false);"></td>
    <td nowrap class="crm-contact-activity-activity_type">{$field.date|date_format:"%d-%m-%Y"}</td>
    <td class="crm-contact-activity-source_contact"><b>{$field.target}</b></td>
    <td class="">
      {if $field.sequence}
      <span style="background-color: #cccccc; padding: 2px 4px; border-radius: 3px;">{$field.sequence}</span>
      {/if}
      {$field.total} {$field.currency}
      <br/>
      <span style="color: #ccc; font-size: 0.9em;">{$field.reference}</span>
    </td>
    <td style="text-align: center; vertical-align: middle;" class="crm-contact-activity-source_contact">{$field.count}</td>
    <td style="text-align: center; vertical-align: middle;" class="crm-contact-activity-source_contact">{$field.analysed}</td>
    <td style="text-align: center; vertical-align: middle;" class="crm-contact-activity-source_contact">{$field.completed}</td>
    <td style="text-align: center; vertical-align: middle;" class="crm-contact-activity_subject">{$field.state}</td>
    <td class="hiddenElement">status-overdue</td>
  </tr>
  {/foreach}
</tbody>
{/if}
</table>
{/if}            {* ENDIF: ROWS FOUND -> CREATE TABLE *}

<p>{ts domain='org.project60.banking'}With selected items perform:{/ts}<br/>
<a id="reviewButton"  class="button" onClick="callWithSelected('{$url_review_selected_payments}', false)" ><span>{ts domain='org.project60.banking'}Review{/ts}</span></a>
<a id="processButton" class="button" onClick="processSelected()"><span>{ts domain='org.project60.banking'}Process{/ts}</span></a>
{if $show == 'statements'}
<a id="listButton" class="button" onClick="callWithSelected('{$url_show_payments}', true)"><span>{ts domain='org.project60.banking'}List Lines{/ts}</span></a>
{/if}
<a id="exportButton"  class="button" onClick="callWithSelected('{$url_export_selected_payments}', false)"><span>{ts domain='org.project60.banking'}Export{/ts}</span></a>
<a id="deleteButton"  class="button {if not $can_delete}disabled{/if}" onClick="deleteSelected()"><span>{ts domain='org.project60.banking'}Delete{/ts}</span></a>
</p>



<!-- Required JavaScript functions -->
<script language="JavaScript">
var busy_icon = '<img name="busy" src="{$config->resourceBase}i/loading.gif" />';

{literal}
cj("#banking_selector").change(function() {
  checkboxes = document.getElementsByName('payment_selected');
  for(var i=0, n=checkboxes.length; i<n; i++) {
    checkboxes[i].checked = this.checked;
  }
});

function getSelected() {
  checkboxes = document.getElementsByName('payment_selected');
  var selected = "";
  for(var i=0, n=checkboxes.length; i<n; i++) {
    if (checkboxes[i].checked) {
      id = checkboxes[i].id;
      if (selected.length) selected += ",";
      selected += checkboxes[i].id.substring(6)
      //selected.push(checkboxes[i].id.substring(6));
    }
  }
  return selected;
}

function callWithSelected(url, forced) {
  var selected = getSelected();
  if (selected || forced) {
    location.href = url.replace("__selected__", selected);
  } else {
    {/literal}
    var message = "{ts domain='org.project60.banking'}Please select one or more items{/ts}";
    {literal}
    window.alert(message);
  }
}

function banking_view_analysed() {
  // will go to the 'analysed' view of the current panel
  var analysed_url = "{/literal}{$url_show_payments_analysed}{literal}";
  window.location = analysed_url;
}

function processSelected() {
  if (cj("#processButton").hasClass('disabled')) return;

  // disable the button
  cj("#processButton").addClass('disabled');

  // mark all selected rows as busy
  var selected_string = getSelected();
  var selected = selected_string.split(',');
  for (var i=0; i<selected.length; i++) {
    cj("#check_" + selected[i]).replaceWith(busy_icon);
  }

  // AJAX call the analyser
  var query = {
    'q': 'civicrm/ajax/rest',
    'sequential': 1,
    '{/literal}{if $show eq 'statements'}s_list{else}list{/if}{literal}': selected_string,
    'use_runner': 50, // TODO: setting?
    'back_url': window.location.href
  };
  CRM.api('BankingTransaction', 'analyselist', query,
    {success: function(data) {
        if (!data['is_error']) {
          if ('runner_url' in data.values) {
            // this is a runner -> jump there to execute
            var runner_url = cj("<div/>").html(data.values['runner_url']).text();
            window.location = runner_url;
            return;
          }

          if (!data.values.timed_out) {
            // perfectly normal result, notify user
            {/literal}
            var message = "{ts domain='org.project60.banking'}_1 payments have been processed successfully, _2 had already been completed. The processing took _3s.{/ts}";
            {literal}
            message = message.replace('_1', data.values.processed_count);
            message = message.replace('_2', data.values.skipped_count);
            message = message.replace('_3', data.values.time);
            CRM.alert(message, "info");
            window.setTimeout("banking_view_analysed();", 1500);

          } else {
            // this is a time out
            {/literal}
            var message = "{ts domain='org.project60.banking'}<p>_1 out of _2 payments have not been processed!</p><p>If you need to process large amounts of payments manually, please adjust PHPs <code>max_execution_time</code>.</p>{/ts}";
            {literal}
            message = message.replace('_1', data.values.payment_count-data.values.processed_count);
            message = message.replace('_2', data.values.payment_count);
            cj('<div title="{/literal}{ts domain='org.project60.banking'}Process timed out{/ts}{literal}"><span class="ui-icon ui-icon-alert" style="float:left;"></span>' + message + '</div>').dialog({
              modal: true,
              buttons: {
                Ok: function() { location.reload(); }
              }
            });
          }
        } else {
          cj('<div title="{/literal}{ts domain='org.project60.banking'}Error{/ts}{literal}"><span class="ui-icon ui-icon-alert" style="float:left;"></span>' + data['error_message'] + '</div>').dialog({
            modal: true,
            buttons: {
              Ok: function() { location.reload(); }
            }
          });
        }
      }
    }
  );
}

function deleteSelected() {
  if (cj("#deleteButton").hasClass('disabled')) return;

  CRM.confirm(function()
  {
    // disable ALL buttons
    cj(".button").addClass('disabled');
    cj(".button").attr("onclick","");

    // mark all selected rows as busy
    var selected_string = getSelected();
    var selected = selected_string.split(',');
    for (var i=0; i<selected.length; i++) {
      cj("#check_" + selected[i]).replaceWith(busy_icon);
    }

    // call the API to delete the items
    var query = {'q': 'civicrm/ajax/rest', 'sequential': 1};
    // set the list or s_list parameter depending on the page mode
    query['{/literal}{if $show eq 'statements'}s_list{else}list{/if}{literal}'] = selected_string;
    CRM.api('BankingTransaction', 'deletelist', query,
      {success: function(data) {
          if (!data['is_error']) {
            // perfectly normal result, notify user
            {/literal}
            var message = "{ts domain='org.project60.banking'}_1 payments in _2 statements have been deleted.{/ts}";
            {literal}
            message = message.replace('_1', data.values.tx_count);
            message = message.replace('_2', data.values.tx_batch_count);
            CRM.alert(message, "info");
            window.setTimeout("location.reload()", 1500);
          } else {
            cj('<div title="{/literal}{ts domain='org.project60.banking'}Error{/ts}{literal}"><span class="ui-icon ui-icon-alert" style="float:left;"></span>' + data['error_message'] + '</div>').dialog({
              modal: true,
              buttons: {
                Ok: function() { location.reload(); }
              }
            });
          }
        }
      }
    );
  },
  {
    title: {/literal}"{ts domain='org.project60.banking'}Are you sure?{/ts}"{literal},
    message: {/literal}"{ts domain='org.project60.banking'}Do you really want to permanently delete the selected items?{/ts}"{literal}
  });
}
</script>
{/literal}

