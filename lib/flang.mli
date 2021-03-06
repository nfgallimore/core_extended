(** The language of terms over a field. *)

module type Field = sig
  type t
  val ( + ) : t -> t -> t
  val ( - ) : t -> t -> t
  val ( * ) : t -> t -> t
  val ( / ) : t -> t -> t
end

type 'a t = [
  | `Base of 'a
  | `Add  of 'a t * 'a t
  (** sexp [(x + y)] or [(add x y z ...)]. An empty list ([(add)]) is not allowed. *)
  | `Sub  of 'a t * 'a t
  (** sexp [(x - y)] or [(sub x y)] *)
  | `Mult of 'a t * 'a t
  (** sexp [(x * y)] or [(mult x y z ...)]. An empty list ([(mult)]) is not allowed. *)
  | `Div  of 'a t * 'a t
  (** sexp [(x / y)] or [(div x y)] *)
] with sexp, bin_io, compare

val base : 'a -> 'a t
val add  : 'a t -> 'a t -> 'a t
val sub  : 'a t -> 'a t -> 'a t
val mult : 'a t -> 'a t -> 'a t
val div  : 'a t -> 'a t -> 'a t
val add_list  : 'a t list -> 'a t
val mult_list : 'a t list -> 'a t

module Eval (F : Field) : sig
  val eval : 'a t -> f:('a -> F.t) -> F.t
end
