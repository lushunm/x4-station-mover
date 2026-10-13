--[[
X4 Station Mover — マップ選択解除ヘルパー

MDの raise_lua_event('X4_Station_Mover.Deselect') を受けて、マップメニューの
選択状態を解除する。右クリックで移動モードを開始すると対象ステーションが
選択状態のまま残り、移動先の右クリックが「選択ユニットへの命令メニュー」に
なって「ここへ移動」(mainセクション)が表示されないため。

- MapMenu はグローバル Menus から name=="MapMenu" で取得
  （sn_mod_support_apis ui/library.lua の Get_Egosoft_Menu と同イディオム）。
- clearSelectedComponents() は menu_map.lua の公開関数
  （selectedcomponents をクリアして updateTableSelection() を呼ぶだけ）。
]]

local function findMapMenu()
    if Menus == nil then
        return nil
    end
    for _, m in ipairs(Menus) do
        if m.name == "MapMenu" then
            return m
        end
    end
    return nil
end

local function onDeselect()
    local mapMenu = findMapMenu()
    if mapMenu and mapMenu.clearSelectedComponents then
        -- マップが開いていない状態で呼ばれても実害はないが、念のため保護する
        pcall(mapMenu.clearSelectedComponents)
    end
end

local function init()
    RegisterEvent("X4_Station_Mover.Deselect", onDeselect)
end
init()
