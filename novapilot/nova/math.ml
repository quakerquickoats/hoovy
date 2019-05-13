(* any two points are colinear *)
(* any three points are coplanar *)
type point = float
type line = point * point
type plane = line * point   (* shouldnt be on same line, noncolinear *)

(* the intersection of two lines is a point  *)
(* the intersection of two planes is a line *)

type segment = point * point (* part of a line *)
type ray = point * point (* point and direction *)
(* opposite ray shares endpoint and inverted direction *)
(* segments with equal lengths are considered Congruent *)
(* B is between A and C if they are colinear and AB + BC = AC. *)
(* midpoint of a segment is the point that divides into
   two congruent segments *)
(* a segment bisector is any line, ray, plane or segment that
   intersects a segment at midpoint. *)
(* a perpendicular bisector intersects the segment and is
   perpendicular to it. *)

type angle = point * point * point   (* *)

(* and ANGLE is a figure formed by two rays with a common endpoint. *)
(* the common endpoint is the VERTEX of the Angle *)
(* the Rays are the sides of the angle *)
(* angles are formed when lines, rays, or segments intersect *)
(* an Angle divides the Plane into two regions, Interior and Exterior. *)
(* if two Points from each side of the Angle are connected with a
   Segment, the Segment passes through the interior of the Angle. *)

type compassDirection =
  North | NorthEast | East | SouthEast | South |
  SouthWest | West | NorthWest                                                                    
