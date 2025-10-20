CREATE ROLE ruby LOGIN PASSWORD 'tez48oFltYDzEcCK';

CREATE TABLE IF NOT EXISTS data (
    id          bigserial PRIMARY KEY,
    first_name  VARCHAR(64)        NOT NULL,
    last_name   VARCHAR(64)        NOT NULL,
    email       VARCHAR(128)       UNIQUE,
    position    VARCHAR(128)       NOT NULL,
    created_at  timestamptz NOT NULL DEFAULT now()
);

INSERT INTO data (first_name, last_name, email, position)
VALUES
('Trey','Turner','mirta@stanton.example','Hospitality Representative'),
('Luciana','Abbott','lillian.ernser@collier.test','Education Assistant'),
('Randee','O''Connell','orval@weimann-rodriguez.test','District Agent'),
('Daisy','Kovacek','chere@schmitt-mcclure.example','Legacy Government Strategist'),
('Benito','Pagac','georgeanna.miller@auer.example','Global Supervisor'),
('Ed','Predovic','matt@mertz-cummings.test','Future Design Consultant'),
('Walker','Smitham','elvira_beier@sporer-ward.test','Banking Agent'),
('Louisa','O''Kon','saul@welch.example','Healthcare Orchestrator'),
('Aurea','Vandervort','antionette_schuster@predovic.test','Mining Designer'),
('Lilly','Deckow','bernard@ohara.test','Future Planner'),
('Roman','Pouros','ruben_langosh@oberbrunner.test','Farming Engineer'),
('Steven','Bosco','ben_morar@terry-sauer.test','Retail Director'),
('Jere','DuBuque','kalyn@reichel-douglas.example','Chief Healthcare Designer'),
('Birdie','Cartwright','gayle_weissnat@labadie.example','Lead Consultant'),
('Abigail','Fahey','venita_bergnaum@zemlak.example','Sales Coordinator'),
('Bill','Jaskolski','michael_rau@reinger-schroeder.test','Construction Producer'),
('Lucas','Halvorson','edgardo.hermann@carter.example','Internal Legal Architect'),
('Augustus','Green','loris@jacobson.example','Dynamic Advertising Associate'),
('Delpha','Lubowitz','scotty@crona.test','Community-Services Analyst'),
('Horacio','Satterfield','alphonse_kohler@schamberger.example','IT Administrator'),
('Janessa','Schinner','florida.prosacco@walker.test','Consulting Liaison'),
('Spencer','Stroman','deloras@barton.test','Principal Construction Associate'),
('Briana','Abernathy','loria@jast.example','Investor Hospitality Supervisor'),
('Maddie','Glover','rickey.effertz@brown.example','National Specialist'),
('Renita','Rolfson','tanner_bartell@moore.example','Direct Liaison'),
('Jewell','Kutch','jinny@maggio-hirthe.example','Mining Representative'),
('Wilburn','Ratke','sage@emard-runolfsdottir.test','Forward Administration Architect'),
('Fausto','O''Kon','daina.barton@runolfsson.example','Global Officer'),
('Donald','Considine','detra_gutmann@koepp.test','Banking Coordinator'),
('Jonathan','Boyer','brice@schroeder-veum.example','Product Retail Agent'),
('Alonzo','McGlynn','erik@funk-kshlerin.example','Corporate Community-Services Coordinator'),
('Doyle','Kessler','sydney@nitzsche.test','Global Administration Administrator'),
('Bulah','Johnston','cruz@bode.example','Marketing Planner'),
('Darcy','Stiedemann','windy.kovacek@davis-reichert.example','Manufacturing Facilitator'),
('Wilson','Stiedemann','bud@wintheiser.example','Technology Agent'),
('Graham','Orn','analisa.shields@marquardt-moen.example','Mining Architect'),
('Gertha','Mitchell','erlene@von.example','International Hospitality Orchestrator'),
('Jay','Deckow','gearldine.gleichner@heathcote.test','Accounting Producer'),
('Sol','Koelpin','al@wiza-greenfelder.example','Marketing Executive'),
('Ozie','Mayert','wilburn_bashirian@corkery.test','Real-Estate Liaison'),
('Rey','White','felton.franecki@mccullough.example','Direct Legal Assistant'),
('Emmanuel','Jacobi','daniela_hirthe@little-wisoky.test','Technology Producer'),
('Scottie','Marks','shad_toy@witting.test','Farming Developer'),
('Bruce','Luettgen','raylene.leffler@padberg-torphy.test','Administration Director'),
('Amira','Rowe','charlesetta@beatty.example','Farming Officer'),
('Olen','Hilpert','chase@cassin.example','Lead Mining Analyst'),
('Demarcus','Kshlerin','tristan_schuppe@brakus.example','Legal Director'),
('Brent','Goldner','arron.okon@gutkowski.test','Accounting Analyst'),
('Son','Ledner','sook_koelpin@towne.test','Forward Sales Consultant'),
('Elden','Douglas','scott@crona.example','Forward Executive')
ON CONFLICT (email) DO NOTHING;

CREATE TABLE private (
    id SERIAL PRIMARY KEY,
    flag TEXT
);

INSERT INTO private(flag) VALUES ('SSU{4sk_4nd_yOu_sh4ll_r3c3iv3-XLLDAGB761}');

REVOKE CONNECT ON DATABASE postgres FROM ruby;
GRANT CONNECT ON DATABASE chal_db TO ruby;

GRANT USAGE ON SCHEMA public TO ruby;

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM ruby;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ruby;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO ruby;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON TABLES FROM ruby;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO ruby;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT USAGE, SELECT ON SEQUENCES TO ruby;
