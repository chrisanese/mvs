<!-- Start: New Lecturer Modal -->
	<div class="modal fade mod-lecturer-modal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" id="lecturer-modal">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header text-center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h2 class="modal-title">Neuen Dozenten/Tutor hinzuf&uuml;gen</h2>
				</div>
				<div class="modal-body">
					<div class="alert text-center hidden" id="validateLecturer"></div>
					<form class="form-horizontal" role="form">
						<div class="form-group has-feedback">
							<label for="lTypSelect" class="col-sm-3 control-label">Typ</label>
							<div class="col-sm-9">
								<select id="lTypSelect" class="form-control">
									<option class="dropdown-option lTypOption" value="1">Dozent</option>
									<option class="dropdown-option lTypOption" value="2">Tutor</option>
									<option class="dropdown-option lTypOption" value="3">Verwaltung</option>
									<option class="dropdown-option lTypOption" value="4">Sekretariat</option>
								</select>
							</div>
						</div>
						<div class="form-group has-feedback">
							<label for="lVorname" class="col-sm-3 control-label">Vorname *</label>
							<div class="col-sm-9">
								<input type="text" id="lVorname" class="form-control" placeholder="Vorname" required="required">
							</div>
						</div>
						<div class="form-group has-feedback">
							<label for="lNachname" class="col-sm-3 control-label">Nachname *</label>
							<div class="col-sm-9">
								<input type="text" id="lNachname" class="form-control" placeholder="Nachname" required="required">
							</div>							
						</div>

						<div class="form-group has-feedback">
							<label for="lZedat" class="col-sm-3 control-label">Zedat Account:</label>
							<div class="col-sm-9">
								<input type="text" id="lZedat" class="form-control" placeholder="Zedat-Account">
							</div>
						</div>
						<div class="form-group has-feedback">
							<label for="lEmail" class="col-sm-3 control-label">Email:</label>
							<div class="col-sm-9">
								<input type="email" id="lEmail" class="form-control" placeholder="Email">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Schliessen</button>
					<button type="button" class="btn btn-primary" id="addLecturer">Hinzuf&uuml;gen</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End New Lecturer Modal -->
	
	
	<!-- Start: Edit Module Modal -->
	<div class="modal fade mod-editModule-modal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" id="editModule-modal">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header text-center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h2 class="modal-title">Welches Modul soll bearbeitet werden?</h2>
				</div>
				<div class="modal-body">
				{{#editM}}
					<form class="form-horizontal" role="form">
						<div class="form-group has-feedback">
							<label for="editMISelect" class="col-sm-3 control-label">Studiengang</label>
							<div class="col-sm-9">
								<select id="editMISelect" class="form-control">
									<option class="dropdown-option lTypOption" value="1">Informatik</option>
									<option class="dropdown-option lTypOption" value="2">Mathematik</option>
									<option class="dropdown-option lTypOption" value="3">Physik</option>
									<option class="dropdown-option lTypOption" value="4">Bioinformatik</option>
								</select>
							</div>
						</div>
						<div class="form-group has-feedback">
							<label for="editMStaSelect" class="col-sm-3 control-label">Studienart</label>
							<div class="col-sm-9">
								<select id="editMStaSelect" class="form-control">
									<option class="dropdown-option lTypOption" value="1">Bachelor</option>
									<option class="dropdown-option lTypOption" value="2">Master</option>
									<option class="dropdown-option lTypOption" value="3">Lehramt</option>
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-1-1">
							<label for="editM-1-1" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-1-1" class="form-control eModuleSelect">
									{{#binfo}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/binfo}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-1-2 hidden">
							<label for="editM-1-2" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-1-2" class="form-control eModuleSelect">
									{{#minfo}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/minfo}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-1-3 hidden">
							<label for="editM-1-3" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-1-3" class="form-control eModuleSelect">
									{{#linfo}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/linfo}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-2-1 hidden">
							<label for="editM-2-1" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-2-1" class="form-control eModuleSelect">
									{{#bmathe}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/bmathe}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-2-2 hidden">
							<label for="editM-2-2" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-2-2" class="form-control eModuleSelect">
									{{#mmathe}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/mmathe}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-2-3 hidden">
							<label for="editM-2-3" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-2-3" class="form-control eModuleSelect">
									{{#lmathe}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/lmathe}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-3-1 hidden">
							<label for="editM-3-1" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-3-1" class="form-control eModuleSelect">
									{{#bphysik}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/bphysik}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-3-2 hidden">
							<label for="editM-3-2" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-3-2" class="form-control eModuleSelect">
									{{#mphysik}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/mphysik}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-3-3 hidden">
							<label for="editM-3-3" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-3-3" class="form-control eModuleSelect">
									{{#lphysik}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/lphysik}}
								</select>
							</div>
						</div>						
						<div class="form-group has-feedback editModule editModule-4-1 hidden">
							<label for="editM-4-1" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-4-1" class="form-control eModuleSelect">
									{{#bbio}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/bbio}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-4-2 hidden">
							<label for="editM-4-2" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-4-2" class="form-control eModuleSelect">
									{{#mbio}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/mbio}}
								</select>
							</div>
						</div>
						<div class="form-group has-feedback editModule editModule-4-3 hidden">
							<label for="editM-4-3" class="col-sm-3 control-label">Modul w&auml;hlen</label>
							<div class="col-sm-9">
								<select id="editM-4-3" class="form-control eModuleSelect">
									{{#lbio}}
									<option class="dropdown-option module module-{{staId}}" value="{{mId}}">{{mName}}</option>
									{{/lbio}}
								</select>
							</div>
						</div>
					</form>
				{{/editM}}
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Schliessen</button>
					<button type="button" class="btn btn-primary" id="editModule">Hinzuf&uuml;gen</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End Edit Module Modal -->
	
	<!-- Start: Login Modal -->
	<div class="modal fade mod-login-modal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true" id="login-modal">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header text-center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h2 class="modal-title">Login</h2>
				</div>
				<div class="modal-body">
				<input type="text" id="loginUname" class="form-control" placeholder="Benutzername" required="required">
				<input type="password" id="loginPw" class="form-control" placeholder="Passwort" required="required">
				</div>
				<div class="modal-footer">
					<div class="text-center">						
						<a id="logLink" class="btn btn-success signin">Login</a>
						<button type="button" class="btn btn-default" data-dismiss="modal">Schliessen</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Login Modal -->
