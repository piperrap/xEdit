{
  Purpose: Remove ownership from flora
  Game: The Elder Scrolls V: Skyrim
  Author: Ryan ryan.a.piper@gmail.com 
   after: dalen <erik.gustav.dalen@gmail.com>
          https://github.com/dalen/xedit-scripts.git
  Version: 0.1
}
unit userscript;

procedure RemoveOwnership(e: IInterface);
var
  ownerElement: IInterface;
begin
   ownerElement := ElementByPath(e, 'Ownership');
  RemoveElement(e, ownerElement);
end;

// called for every record selected in xEdit
function Process(e: IInterface): integer;
var
  val: integer;
  ParentCell, Worldspace, PlacedObject, owner: IInterface;
  WorldspaceName: string;
begin
  Result := 0;

  // Skip if not a REFR
  if Signature(e) <> 'REFR' then exit;

  PlacedObject := LinksTo(ElementByName(e, 'NAME - Base'));

  // Skip if placed object type is not TreeFlora*
  //if not StrPos(EditorID(PlacedObject), 'TreeFlora') then exit;
  if not StartsStr('USKPTreeFlora', EditorID(PlacedObject)) then exit;

  // Skip items that already don't have owners
  owner := ElementByPath(e, 'Ownership');
  if not (owner <> nil) then exit;

  ParentCell := LinksTo(ElementByName(e, 'Cell'));
  Worldspace := LinksTo(ElementByName(ParentCell, 'Worldspace'));
  WorldspaceName := EditorID(Worldspace);

  AddMessage('Processing: ' + FullPath(e));
  AddMessage('Object: ' + EditorID(PlacedObject));
  AddMessage('Worldspace: ' + WorldspaceName);

  RemoveOwnership(e)
end;

end.
