<div style="position: absolute; top: 10px; right: 10px;">
  <a href="#" onclick="Scuttle.Editor.preview(); return false">Vorschau</a>
  | <a href="#" onclick="Scuttle.show('Editor', 'editor/menu'); return false">Zurück</a>
  | <a href="#" onclick="Scuttle.hide(); return false">X</a>
</div>


<div id="scuttle-editor-controls" class="scuttle-toolbox">

{{#tools}}
<input
  type="button" onclick="Scuttle.Editor.selectTool({{ix}})"
  value="{{name}}" class="scuttle-tool-btn" />
{{/tools}}

</div>

<div id="scuttle-editor-inspector" class="scuttle-toolbox">
  <div class="scuttle-editbox tool1">
    <label>Raum-Nummer: <input type="text" id="scuttle-room-id" data-match="roomId" /></label>
    <label>Name: <input type="text" id="scuttle-room-name" data-match="name" /></label>
    <label>Kapazität: <input type="text" id="scuttle-room-capacity" data-match="capacity" /></label>
    <label><input type="checkbox" id="scuttle-room-feature1" /> Beamer</label>
    <label><input type="checkbox" id="scuttle-room-feature2" /> E-Chalk</label>
    <label><input type="checkbox" id="scuttle-room-feature3" /> PC-Pool</label>
  </div>
  <div class="scuttle-editbox tool2">
    <label>Beschriftung: <input type="text" id="scuttle-floor-name" data-match="label" /></label>
  </div>
  <div class="scuttle-editbox tool3">
  
  </div>
  <div class="scuttle-editbox tool4">
    <label>Beschriftung: <input type="text" id="scuttle-grass-name" data-match="label" /></label>
  </div>
  <div class="scuttle-editbox tool5">
    <label>Beschriftung: <input type="text" id="scuttle-street-name" data-match="label" /></label>
  </div>
</div>

<div id="scuttle-editor">

<div id="scuttle-grid" data-floor="{{floor}}">
  {{#features}}
  <div class="scuttle-editor-object scuttle-{{type}}"
    data-uuid="{{uuid}}" data-key="{{id}}"
    data-type="{{type}}" data-label="{{name}}"
    style="top: {{posY}}px; left: {{posX}}px; width: {{width}}px; height: {{height}}px;"></div>
  {{/features}}

  {{#rooms}}
  <div class="scuttle-editor-object scuttle-room"
    data-uuid="{{uuid}}" data-key="{{id}}"
    data-type="room" data-name="{{name}}"
    data-roomId="{{roomId}}" data-capacity="{{capacity}}"
    style="top: {{posY}}px; left: {{posX}}px; width: {{width}}px; height: {{height}}px;">
    {{roomId}}<br />
    {{name}}
    {{#features}}
      <div class="scuttle-editor-object scuttle-{{type}} {{data}}"
        data-key="{{id}}" data-uuid="{{uuid}}"
        style="top: {{posY}}px; left: {{posX}}px;"></div>
    {{/features}}  
  </div>
  {{/rooms}}

  <div id="scuttle-hover"></div>
</div>

</div>

<script>Scuttle.Editor.initEditor()</script>