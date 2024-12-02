USE P3
GO

CREATE TABLE Includes (
    productID INT NOT NULL REFERENCES Product(productID) ON DELETE CASCADE,
    ingredientID INT NOT NULL REFERENCES Ingredient(ingredientID) ON DELETE CASCADE,
    PRIMARY KEY (productID, ingredientID)
);

INSERT INTO Includes (productID, ingredientID) VALUES
    (1, 1),
    (2, 4),
    (3, 1),
    (4, 2),
    (5, 2),
    (6, 1),
    (7, 5),
    (8, 6),
    (9, 2),
    (10, 4),
    (10, 2),
    (11, 3),
    (12, 2),
    (12, 5),
    (13, 2),
    (14, 4),
    (15, 6),
    (16, 2),
    (17, 3),
    (18, 2),
    (19, 5),
    (20, 2),
    (21, 3),
    (22, 2),
    (23, 4),
    (23, 5),
    (24, 2),
    (25, 4),
    (25, 6),
    (26, 2),
    (27, 2),
    (28, 3),
    (28, 2),
    (29, 2),
    (30, 4),
    (30, 5),
    (31, 2),
    (32, 4),
    (33, 2),
    (34, 2),
    (35, 4),
    (36, 6),
    (37, 5),
    (38, 2),
    (39, 4),
    (40, 2),
    (41, 3),
    (41, 2),
    (42, 4),
    (43, 2),
    (44, 6),
    (45, 2),
    (46, 4),
    (47, 2),
    (48, 3),
    (48, 5),
    (49, 6),
    (50, 2),
    (51, 1),
    (52, 4),
    (53, 2),
    (54, 3),
    (55, 5),
    (56, 6),
    (57, 2),
    (58, 4),
    (58, 2),
    (59, 1),
    (60, 3),
    (61, 2),
    (62, 2),
    (63, 6),
    (64, 5),
    (65, 2),
    (66, 3),
    (67, 4),
    (68, 1),
    (69, 2),
    (70, 3),
    (71, 4),
    (72, 2),
    (73, 3),
    (74, 4),
    (75, 2),
    (76, 5),
    (77, 2),
    (78, 3),
    (79, 4),
    (80, 5),
    (81, 2),
    (82, 1),
    (83, 3),
    (84, 2),
    (85, 5),
    (86, 4),
    (87, 6),
    (88, 2),
    (89, 3),
    (90, 2),
    (91, 1),
    (92, 4),
    (93, 2),
    (94, 5),
    (95, 2),
    (96, 3),
    (97, 4),
    (98, 2),
    (99, 5),
    (100, 1),
    (101, 2),
    (102, 3),
    (103, 5),
    (104, 6),
    (105, 1),
    (106, 4),
    (107, 2),
    (108, 3),
    (109, 4),
    (110, 1),
    (111, 5),
    (112, 3),
    (113, 2),
    (114, 6),
    (115, 5),
    (116, 1),
    (117, 4),
    (118, 2),
    (119, 3),
    (120, 2),
    (121, 3),
    (122, 4),
    (123, 2),
    (124, 5),
    (125, 1),
    (126, 3),
    (127, 6),
    (128, 5),
    (129, 4),
    (130, 2),
    (131, 1),
    (132, 2),
    (133, 5),
    (134, 3),
    (135, 2),
    (136, 1),
    (137, 2),
    (138, 5),
    (139, 4),
    (140, 3),
    (141, 1),
    (142, 2),
    (143, 5),
    (144, 4),
    (145, 3),
    (146, 6),
    (147, 2),
    (148, 5),
    (149, 1),
    (150, 4),
    (151, 3),
    (152, 2),
    (153, 5),
    (154, 1),
    (155, 3),
    (156, 2),
    (157, 4),
    (158, 5),
    (159, 1),
    (160, 2),
    (161, 4),
    (162, 5),
    (163, 2),
    (164, 3),
    (165, 1),
    (166, 5),
    (167, 4),
    (168, 3),
    (169, 6),
    (170, 5);

SELECT * FROM Includes;