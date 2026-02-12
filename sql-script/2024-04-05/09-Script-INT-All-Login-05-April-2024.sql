ALTER TABLE IF EXISTS ui.activelogintokens
    ADD COLUMN isgeneratedthroughrefreshtoken boolean;


DELETE FROM ui.activelogintokens;