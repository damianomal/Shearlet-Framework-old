function shearlet_browse_callback(fig_obj, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% add this part as an experiment and see what happens!
get(fig_obj, 'CurrentKey');
get(fig_obj, 'CurrentCharacter');
get(fig_obj, 'CurrentModifier');


end
