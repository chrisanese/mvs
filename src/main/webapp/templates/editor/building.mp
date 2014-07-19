<h3>
  {{#name}}{{name}} ({{address}}){{/name}}
  {{^name}}{{address}}{{/name}}
</h3>
<div>

<input type="button" onclick="Scuttle.Editor.removeBuilding({{id}})" value="Dieses Gebäude entfernen" />
<input type="button" onclick="Scuttle.Editor.removeFloors({{id}})" value="Die ausgewählten Stockwerke entfernen" />

<p id="scuttle-floors-{{id}}" class="scuttle-floors">
{{#floors}}
  {{> floor}}
{{/floors}}
</p>

<form onsubmit="Scuttle.Editor.newFloor({{id}}) ; return false" id="scuttle-newFloor-{{id}}">
  <label>
    <span>Neues Stockwerk:</span>
    <input type="text" name="name" />
  </label>
  <input type="submit" value="Hinzufügen" />
  <input type="hidden" name="building" value="{{id}}" />
</form>

</div>